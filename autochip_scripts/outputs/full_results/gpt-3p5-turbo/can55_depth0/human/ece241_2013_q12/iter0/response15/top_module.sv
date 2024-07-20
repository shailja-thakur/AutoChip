module shift_register (
	input clk,
	input enable,
	input S,
	output [7:0] Q
);

	reg [7:0] q;

	always @(posedge clk) begin
		if (enable) begin
			q <= {S, q[7:1]};
		end
	end

	assign Q = q;

endmodule
module multiplexer (
	input [7:0] input_signals,
	input [2:0] select,
	output reg output_signal
);

	always @(select) begin
		case (select)
			3'b000: output_signal <= input_signals[0];
			3'b001: output_signal <= input_signals[1];
			3'b010: output_signal <= input_signals[2];
			3'b011: output_signal <= input_signals[3];
			3'b100: output_signal <= input_signals[4];
			3'b101: output_signal <= input_signals[5];
			3'b110: output_signal <= input_signals[6];
			3'b111: output_signal <= input_signals[7];
		endcase
	end

endmodule
module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);
	
	wire [7:0] Q;

	shift_register u_shift_register (
		.clk(clk),
		.enable(enable),
		.S(S),
		.Q(Q)
	);

	multiplexer u_multiplexer (
		.input_signals(Q),
		.select({A,B,C}),
		.output_signal(Z)
	);

endmodule
