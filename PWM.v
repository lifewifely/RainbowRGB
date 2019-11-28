module PWM
(input CLK
,input FLAG
,input _OE
,output STT
,output PWM
);

reg[24:0]cnt1;//Max=33554431
reg[24:0]cnt2;
reg stt;

parameter FREQ=3464;//2*(FREQ)^2=24M=2s

always@(posedge CLK)
	if(cnt1>=FREQ)
		cnt1<=1'b0;
	else
		cnt1<=cnt1+1'b1;

always@(posedge CLK)
	if(cnt1==FREQ)
		if(FLAG)
			if(cnt2>=FREQ)begin
				cnt2<=1'b0;stt<=1'b1;
			end
			else begin
				cnt2<=cnt2+1'b1;stt<=1'b0;
			end
		else
			if(cnt2<=0)
				cnt2<=FREQ-1'b1;
			else
				cnt2<=cnt2-1'b1;
	else
		cnt2<=cnt2;

assign PWM=(_OE==1)?((cnt1<cnt2)?1'b0:1'b1):1'b1;//核心
assign STT=stt;

endmodule