module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	reg [3:0] shift_register;

	always @(posedge clk) begin
		if (!resetn) begin
			shift_register <= 4'b0000;
		end else begin
			shift_register <= {shift_register[2:0], in};
		end
	end

	assign out = shift_register[3];

endmodule
