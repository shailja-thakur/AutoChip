module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	reg q_reg; // declare a register to store the value of q

	always @(*) begin
		q_reg = (a & b) | (c & d); // assign the value of q based on input values
	end

	assign q = q_reg; // assign the value of q_reg to q

endmodule
