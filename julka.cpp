#include<cstdio>
int main()
{
    char num[101],a[101],b[101];
    char ch;
    int l=0;

	memset(num,0,sizeof(num));
    ch=getchar();
    while(ch)
    {
        num[l++]=ch-'0';
        ch=getchar();
    }
    
	//calc num+2
    int i,carry=0,temp;
    for(i=0;i<l;i++)
    {
        temp = num[i]+2;
        num[i] = temp%10;
        carry = temp/10;
		if(carry == 0)
			break;
    }
	if(carry)
	{
		num[i]=carry;
		l++;
	}
	// div num+2 by 2

	carry=0;
	int k=0;
	for(i=l-1;i>=0;i--)
	{
		temp = carry*10+num[i];
		a[k++]=temp/2;
		carry=temp%2;
	}
	for(i=0;i<k;i++)
	{
		if(a[i])
			break;
	}
	int start_a=i;

	// 9's complement of 2, of same size as a. stored in num.
	for(i=0;i<k-start_a-1;i++)
	{
		num[i]=9;
	}
	num[i]=7;

	carry=0;
	for(i=k-1;i>=start_a;i--)
	{
		temp=a[i]+num[i-start_a]+carry;
		b[i-start_a]=temp%10;
		carry=temp/10;
	}
	if
