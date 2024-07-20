module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
  
  reg [7:0] q_temp;
  
  always@(posedge clk) begin
    q_temp <= d;
  end
  
  always@(posedge clk) begin
    q <= q_temp;
  end
  
endmodule
