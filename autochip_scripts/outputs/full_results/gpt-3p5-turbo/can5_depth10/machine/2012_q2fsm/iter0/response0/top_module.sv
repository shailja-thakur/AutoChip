module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
wire is_E_or_F;

assign z = is_E_or_F;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000; // Initial state A
	else if (w == 0) begin
		case (state)
			3'b000: state <= 3'b000; // A to A
			3'b001: state <= 3'b100; // B to D
			3'b010: state <= 3'b100; // C to D
			3'b011: state <= 3'b000; // D to A
			3'b100: state <= 3'b100; // E to D
			3'b101: state <= 3'b100; // F to D
		endcase
	end else begin
		case (state)
			3'b000: state <= 3'b001; // A to B
			3'b001: state <= 3'b010; // B to C
			3'b010: state <= 3'b100; // C to E
			3'b011: state <= 3'b101; // D to F
			3'b100: state <= 3'b100; // E to E
			3'b101: state <= 3'b010; // F to C
		endcase
	end
end

always @(state) begin
	case (state)
		3'b100, 3'b101: is_E_or_F = 1;
		default: is_E_or_F = 0;
	endcase
end

endmodule
