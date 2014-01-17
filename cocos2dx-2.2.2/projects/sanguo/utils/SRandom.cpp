#include "SRandom.h"

NS_CC_BEGIN
SRandom::SRandom()
{
}

SRandom::~SRandom()
{
}

double SRandom::nextDouble()
{
	return (((long long) (this->next(26)) << 27) + this->next(27))
		/ (double) (1LL << 53);
}

double SRandom::nextDouble(double n)
{
	return this->nextDouble() * n;
}

double SRandom::nextDouble(double least, double bound)
{
	return (this->nextDouble() * (bound - least)) + least;
}

int SRandom::nextInt32(int n)
{
	if ((n & -n) == n)
		return (int)((n * (long long) this->next(31)) >> 31);

	int bits, val;
	do
	{
		bits = this->next(31);
		val = bits % n;
	}while(((bits - val) + (n - 1)) < 0);

	return val;
}

int SRandom::nextInt32(int least, int bound)
{
	return this->nextInt32(bound - least) + least;
}

long long SRandom::nextInt64(long long n)
{
#undef max
	long long offset = 0;
	while(n >= std::numeric_limits<int>::max())
	{
		int bits = this->next(2);
		long long half = ((unsigned long long)n) >> 1;
		long long nextn = ((bits & 2) == 0) ? half : n - half;
		if ((bits & 1) == 0)
			offset += n - nextn;
		n = nextn;
	}
	return offset + this->nextInt32((int) n);
}

long long SRandom::nextInt64(long long least, long long bound)
{
	return this->nextInt64(bound - least) + least;
}


void SRandom::setSeed(long long seed)
{
	this->rnd = (seed ^ SRandom::MULTIPLIER) & SRandom::MASK;
}

int SRandom::next(int bits)
{
	this->rnd = ((this->rnd * SRandom::MULTIPLIER) + SRandom::ADDEND) & SRandom::MASK;
	return (int)(((unsigned long long)(this->rnd)) >> (48 - bits));
}

NS_CC_END