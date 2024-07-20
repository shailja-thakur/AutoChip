module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
  reg state;
  reg q;

  always @(posedge clk) begin
    if (a == 0 && b == 1)
      state <= 1;
    else if (a == 1 && b == 1)
      state <= 1;
    else if (a == 1 && b == 0)
      state <= 0;
    else
      state <= 0;
  end

  always @(posedge clk) begin
    if (state == 1)
      q <= 1;
    else
      q <= 0;
  end

endmodule
