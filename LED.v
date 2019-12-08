module LED(input CLK,input[2:0]FLAG,output LED);

wire UP;
wire DW;
wire STT0;
wire STT1;
PWM up(CLK,1'b1,STT0,UP);
PWM dw(CLK,1'b0,STT1,DW);

reg[2:0]flag;
reg E=1'b0;

always@(posedge STT0)
	if(!E)begin
		flag<=FLAG;
		E<=1'b1;
	end
	else if(flag==3'b111)
		flag<=1'b0;
	else
		flag<=flag+1'b1;

assign LED=(flag==3'b000)?UP:((flag==3'b001)?DW:1'b1);

endmodule