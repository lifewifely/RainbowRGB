module PWM
(input CLK
,output PWM
);

reg[24:0]cnt1;
reg[24:0]cnt2;
reg flag;

parameter FREQ=2400;

always@(posedge CLK)
	if(cnt1>=FREQ-1) 
		cnt1<=1'b0;
	else 
		cnt1<=cnt1+1'b1; 

always@(posedge CLK)
	if(cnt1==FREQ-1)
		if(!flag)
			if(cnt2>=FREQ-1)
				flag<=1'b1;
			else
				cnt2<=cnt2+1'b1;
		else
			if(cnt2<=0)
				flag<=1'b0;
			else 
				cnt2<=cnt2-1'b1;
	else
		cnt2<=cnt2;

assign PWM=(cnt1<cnt2)?1'b0:1'b1;

endmodule