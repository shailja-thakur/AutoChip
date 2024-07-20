module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
 
 reg [1:0] state;
 
 always @(posedge clk or posedge reset) begin
  if (reset)
   state <= 0;
  else
   case(state)
    0: if (j)
        state <= 1;
       else
        state <= 0;
    1: if (k)
        state <= 0;
       else
        state <= 1;
   endcase
 end
 
 always @(state) begin
  case(state)
   0: out <= 0;
   1: out <= 1;
  endcase
 end
 
endmodule
