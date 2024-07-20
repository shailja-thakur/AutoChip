module top_module(
  input x,
  input y,
  output z);

  assign z = x & y;

endmodule
module mt2015_q4b_ref(
	input x,
	input y,
	output z);
    assign z = x & y;
endmodule
