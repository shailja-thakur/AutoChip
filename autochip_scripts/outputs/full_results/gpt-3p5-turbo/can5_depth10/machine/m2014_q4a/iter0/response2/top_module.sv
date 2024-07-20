module top_module (
	input logic d,
	input logic ena,
	output logic q
);

   always_comb begin
      if (ena)
         q = d;
   end

endmodule
