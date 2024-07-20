module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
  
  reg [7:0] q_tmp;
  
  always @(posedge clk) begin
    if (reset)
      q_tmp <= 8'd34;
    else
      q_tmp <= d;
  end
  
  always @(negedge clk) begin
    q <= q_tmp;
  end
  
endmodule
