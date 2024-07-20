module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);

  reg [31:0] d_last;
  reg clk_prev;
  
  always @(posedge clk) begin
    clk_prev <= clk;
    if (reset)
      out <= 0;
    else begin
      out <= out | (~in & d_last);
      d_last <= in;
    end
  end
  
initial begin
  clk = 0;
  forever begin
    #5 clk = ~clk;
  end
end
  
endmodule
