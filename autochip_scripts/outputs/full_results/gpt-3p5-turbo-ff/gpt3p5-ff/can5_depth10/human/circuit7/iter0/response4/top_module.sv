module top_module (
	input clk,
	input a, 
	output reg q
);
  
  reg q_next;
  always @(posedge clk) begin
    if (a == 0)
      q_next = q;
    else if (q == 0)
      q_next = 1;
    else
      q_next = 0;
  end
  
  always @(posedge clk) begin
    q <= q_next;
  end
  
endmodule
