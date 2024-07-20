module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	reg [3:0] sr;  // 4-bit shift register

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			sr <= 4'b0000;  // reset shift register to 0 when resetn is low
		else
			sr <= {sr[2:0], in};  // shift left and load 'in' into LSB
	end

	assign out = sr[3];  // output the MSB of the shift register

endmodule
