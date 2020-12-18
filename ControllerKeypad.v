module ControllerKeypad
(
   input clk,
   input [3:0]LH,
   input setLH,
   input setRH,
   input setLM,
   input setRM,
   input setSignal,
   input setAlarm,
   input n1,
   input n2,
   input n3,
   input n4,
   input n5,
   input n6,
   input n7,
   input n8,
   input n9,
   input n0,
   output reg[3:0] nout
);

   //Regs for signal of all digits that will be set
   reg sigLHr;
   reg sigRHr;
   reg sigLMin;
   reg sigRMin;

   //Check what digit is being set and assign a decimal value to each keypad button pressed
   always @(posedge clk)
   begin
	sigLHr <= setLH;
	sigRHr <= setRH;
	sigLMin <= setLM;
	sigRMin <= setRM;

	//Converts signals coming from each keypad button to their decimal values
	if(sigLHr) begin 
	   if(n1)
	   nout <= 4'd1;
	   else if(n2)
	      nout <= 4'd2;
	   else if(n0)
	      nout <= 4'd0;
	end else if(sigRHr)begin
		if(LH == 4'd2) begin
			if(n1)
	   			nout <= 4'd1;
	   		else if(n2)
	      		nout <= 4'd2;
	   		else if(n3)
				nout <= 4'd3;
			else if(n0)
				nout <= 4'd0; 
		end else begin
			if(n1)
	   			nout <= 4'd1;
	   		else if(n2)
	      		nout <= 4'd2;
	   		else if(n3)
				nout <= 4'd3;
			else if(n4)
				nout <= 4'd4;
			else if(n5)
				nout <= 4'd5;
			else if(n6)
				nout <= 4'd6;
			else if(n7)
				nout <= 4'd7;
			else if(n8)
				nout <= 4'd8;
			else if(n9)
				nout <= 4'd9;
			else if(n0)
				nout <= 4'd0; 
		end
	end else if(sigLMin)begin
	    if(n1)
	   nout <= 4'd1;
	   else if(n2)
	      nout <= 4'd2;
	   else if(n3)
	      nout <= 4'd3;
	   else if(n4)
	      nout <= 4'd4;
	   else if(n5)
	      nout <= 4'd5;
	   else if(n6)
	      nout <= 4'd6;
	   else if(n0)
	      nout <= 4'd0;
	end else if(sigRMin) begin
	   if(n1)
	   nout <= 4'd1;
	   else if(n2)
	      nout <= 4'd2;
	   else if(n3)
	      nout <= 4'd3;
	   else if(n4)
	      nout <= 4'd4;
	   else if(n5)
	      nout <= 4'd5;
	   else if(n6)
	      nout <= 4'd6;
	   else if(n7)
	      nout <= 4'd7;
	   else if(n8)
	      nout <= 4'd8;
	   else if(n9)
	      nout <= 4'd9;
	   else if(n0)
	      nout <= 4'd0;
	end
	if(setSignal == 0) begin
		if(setAlarm == 0) begin
			nout <= 4'd0;
		end
	end
   end
endmodule