module top_module (
	input a,
	input b,
	input sel_b1,
	input sel_b2,
	output out_assign,
	output reg out_always
);

  // Assign statement to select input a or input b based on sel_b1 and sel_b2
  // If sel_b1 and sel_b2 are both 1, assign input b to out_assign
  // Otherwise, assign input a to out_assign
  assign out_assign = (sel_b1 & sel_b2) ? b : a;

  // Always block to select input a or input b based on sel_b1 and sel_b2
  always @(a, b, sel_b1, sel_b2)
  begin
    // If sel_b1 and sel_b2 are both 1, assign input b to out_always
    // Otherwise, assign input a to out_always
    if (sel_b1 & sel_b2)
      out_always = b;
    else
      out_always = a;
  end

endmodule
