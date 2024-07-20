module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

  reg [7:0] d_ff;
  
  always @(negedge clk) begin
    if (reset)
      d_ff <= 8'b00110100;
    else
      d_ff <= d;
  end
  
  assign q = d_ff;
   
endmodule
