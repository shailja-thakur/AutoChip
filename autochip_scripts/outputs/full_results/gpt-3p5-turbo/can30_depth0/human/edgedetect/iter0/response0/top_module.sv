module top_module(
  input  clk,
  input  [7:0] in,
  output reg [7:0] pedge);

  reg [7:0] in_prev;
  
  always @(posedge clk) begin
    in_prev <= in;
    
    for (integer i = 0; i < 8; i = i + 1) begin
      pedge[i] <= in[i] & ~in_prev[i];
    end
  end
endmodule
