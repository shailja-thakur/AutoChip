module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

   reg [1:0] state;
   always @(posedge clk, posedge reset)
   begin
      if (reset)
         state <= 2'b00;
      else
         case(state)
            2'b00: if (j) state <= 2'b01; else state <= 2'b00;
            2'b01: if (k) state <= 2'b00; else state <= 2'b01;
         endcase
   end
   
   assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
