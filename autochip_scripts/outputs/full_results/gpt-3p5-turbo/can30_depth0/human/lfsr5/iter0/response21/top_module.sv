module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] lfsr_register;

	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr_register <= 5'b1;
		else
			lfsr_register <= {lfsr_register[2] ^ lfsr_register[4], lfsr_register[3:0]};
	end

	assign q = lfsr_register;

endmodule
