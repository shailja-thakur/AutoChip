module top_module(
	input clk,
	input d,
	output reg q);

  reg q_q;
  reg q_d;

  always @(posedge clk or negedge clk) begin
    q_q <= q;
    q_d <= d;
  end

  always @(posedge clk) begin
    if (q_q == 1'b0 && q_d == 1'b1)
      q <= 1'b1;
    else if (q_q == 1'b1 && q_d == 1'b0)
      q <= 1'b0;
  end

endmodule
