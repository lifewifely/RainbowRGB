module PWM
(input CLK
,input FLAG
,output STT
,output PWM
);

reg[24:0]cnt1;
reg[24:0]cnt2;

parameter FREQ=2400;

reg stt;
always@(posedge CLK)
	if(cnt2==FREQ-1)
		stt<=1'b1;
	else
		stt<=1'b0;
assign STT=stt;

always@(posedge CLK)
	if(cnt1>=FREQ-1)
		cnt1<=1'b0;
	else 
		cnt1<=cnt1+1'b1;

always@(posedge CLK)
	if(cnt1==FREQ-1)
		if(FLAG)
			if(cnt2>=FREQ-1)
				cnt2<=1'b0;
			else
				cnt2<=cnt2+1'b1;
		else
			if(cnt2<=0)
				cnt2<=FREQ-1;
			else 
				cnt2<=cnt2-1'b1;
	else
		cnt2<=cnt2;

assign PWM=(cnt1<cnt2)?1'b0:1'b1;

endmodule