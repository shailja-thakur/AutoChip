module top_module(
  input clk,
  input [7:0] d,
  output reg [7:0] q);
  
  reg [7:0] register;
  
  always @(posedge clk) begin
    register <= d;
    q <= register;
  end
  
  initial begin
    register <= 8'h0;
    q <= register;
  end
  
endmodule
