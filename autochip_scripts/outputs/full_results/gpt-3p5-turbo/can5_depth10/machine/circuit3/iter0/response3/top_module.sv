module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

  reg a_reg, b_reg, c_reg, d_reg, q_reg;

  always @(a, b, c, d) begin
    a_reg <= a;
    b_reg <= b;
    c_reg <= c;
    d_reg <= d;
    q_reg <= (a_reg | b_reg) & (c_reg | d_reg);
  end

  assign q = q_reg;

endmodule
