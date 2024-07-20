module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Adding a delay to the q signal to synchronize the output with the input changes
	reg q_reg;
	always @(a or b or c or d)
		begin
			#1 q_reg = (~a & ~b & ~c & ~d) | (~a & ~b & c & d) | (~a & b & ~c & ~d) | (~a & b & c & ~d) | (a & ~b & ~c & d) | (a & ~b & c & ~d) | (a & b & ~c & d) | (a & b & c & d);
		end
  
	assign q = q_reg;
  
endmodule
