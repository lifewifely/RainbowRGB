module PWM
(input CLK
,input RST
,output PWM
);

reg[24:0]cnt1;
reg[24:0]cnt2;
reg flag;

parameter FREQ=2450;

always@(posedge CLK or negedge RST)
	if(!RST)
		cnt1<=13'd0;
	else
		if(cnt1>=FREQ-1'b1)
			cnt1<=1'b0;
		else
			cnt1<=cnt1+1'b1;

always@(posedge CLK or negedge RST)
	if(!RST)begin
		cnt2<=13'd0;
		flag<=1'b0;
	end
	else
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

assign PWM=(cnt1<cnt2)?1'b0:1'b1;//核心

endmodule