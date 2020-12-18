module ControllerSetNumberOutput
(
   input clk,
   input setLH,
   input setRH,
   input setLM,
   input setRM,
   input [3:0]numPad,
   input setSignal,
   input alarmSignal,
   output reg [1:0]LHNumber,
   output reg [3:0]RHNumber,
   output reg [2:0]LMNumber,
   output reg [3:0]RMNumber,
);

   // Check which digit is being set and if is time setting or alarm setting at posedge of clk
   always@(posedge clk)
   begin
      if(setSignal) begin
         if(alarmSignal == 0) begin
            if(setLH)
	            LHNumber <= numPad;
	         else if(setRH)
               RHNumber <= numPad;
            else if(setLM)
               LMNumber <= numPad;
            else if(setRM)
               RMNumber <= numPad;
         end
      end else begin
         if(alarmSignal) begin
            if(setLH)
	            LHNumber <= numPad;
	         else if(setRH)
               RHNumber <= numPad;
            else if(setLM)
               LMNumber <= numPad;
            else if(setRM)
               RMNumber <= numPad;
         end
      end

   end

   //If set and alarm signals are turned off then all output regs are set to 0
   always@(posedge clk)
   begin
      if(setSignal == 0) begin
         if(alarmSignal == 0) begin
            LHNumber = 0;
            RHNumber = 0;
            LMNumber = 0;
            RMNumber = 0;
         end
      end   
   end
endmodule