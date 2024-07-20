module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
  
  reg [2:0] q_next;
  
  always @(posedge clk) begin
    if (a)
      q_next <= q + 1;
    else
      q_next <= q;
  end
  
  always @(posedge clk) begin
    q <= q_next;
  end
  
endmodule
