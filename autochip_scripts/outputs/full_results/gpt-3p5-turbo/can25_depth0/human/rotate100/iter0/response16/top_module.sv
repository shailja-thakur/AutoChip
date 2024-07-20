module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] shift_register;

	always @(posedge clk) begin
		if (load) begin
			shift_register <= data;
		end
		else begin
			case (ena)
				2'b01: shift_register <= {shift_register[0], shift_register[99:1]};
				2'b10: shift_register <= {shift_register[98:0], shift_register[99]};
				default: shift_register <= shift_register;
			endcase
		end
	end

	assign q = shift_register;

endmodule
