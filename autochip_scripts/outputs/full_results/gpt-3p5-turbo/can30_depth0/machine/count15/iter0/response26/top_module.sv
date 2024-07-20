module top_module(
  input clk,
  input reset,
  output reg [3:0] q
);

always @(posedge clk) begin
  if(reset == 1'b1) // added comparison operator
    q <= 4'b0; // corrected the assignment statement
  else
    q <= q + 1; // incremented the counter
end

endmodule
