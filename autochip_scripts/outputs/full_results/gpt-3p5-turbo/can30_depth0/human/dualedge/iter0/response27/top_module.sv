module top_module(
	input clk,
	input d,
	output reg q);
  
  reg q_delayed;
  
  always @(posedge clk) begin
    q_delayed <= q;
    q <= d;
  end
  
  always @(negedge clk) begin
    q <= q_delayed;
  end
  
endmodule
