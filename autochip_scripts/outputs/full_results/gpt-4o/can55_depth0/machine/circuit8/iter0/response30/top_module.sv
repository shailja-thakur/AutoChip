module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

   // Trigger on the negative edge of the clock signal
   always @(negedge clock) begin
       q <= a;
   end

   // Trigger on any change of the input signal a
   always @(a or posedge clock) begin
       if (clock)
           p <= a;
   end

endmodule
