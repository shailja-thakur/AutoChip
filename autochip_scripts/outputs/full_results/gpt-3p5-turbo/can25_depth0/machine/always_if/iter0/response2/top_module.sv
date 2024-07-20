module top_module (
	input a,
	input b,
	input sel_b1,
	input sel_b2,
	output out_assign,
	output reg out_always
);

      // assign out_assign with the logic of selecting either a or b based on sel_b1 and sel_b2
      assign out_assign = (sel_b1 & sel_b2) ? b : a;

      // always block to update out_always whenever the inputs change
      always @(*) begin
         if (sel_b1 & sel_b2)
            out_always <= b;
         else
            out_always <= a;
      end

endmodule
