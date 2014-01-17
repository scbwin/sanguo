#ifndef __SRANDOM_H__
#define __SRANDOM_H__
#include "cocos2d.h"

NS_CC_BEGIN

class SRandom : public CCObject
{
public:

	SRandom();
	virtual ~SRandom();
public:
	double nextDouble();

	double nextDouble(double n);

	double nextDouble(double least, double bound);

	int nextInt32(int n);

	int nextInt32(int least, int bound);

	long long nextInt64(long long n);

	long long nextInt64(long long least, long long bound);

	void setSeed(long long seed);
protected:
	int next(int bits);

private:
	long long rnd;

	static const long long MULTIPLIER	= 0x5DEECE66DLL;
	static const long long ADDEND		= 0xBLL;
	static const long long MASK			= (1LL << 48) - 1LL;
};

NS_CC_END
#endif