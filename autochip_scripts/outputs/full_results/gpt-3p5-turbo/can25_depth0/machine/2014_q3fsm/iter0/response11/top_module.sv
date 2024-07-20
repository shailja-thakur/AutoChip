module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State variables
	reg [3:0] state, next_state;

	// Constants for state encoding
	localparam A = 4'b0001;
	localparam B = 4'b0010;
	localparam C = 4'b0011;
	localparam S10 = 4'b0100;
	localparam S11 = 4'b0101;
	localparam S20 = 4'b0110;
	localparam S21 = 4'b0111;
	localparam S22 = 4'b1000;

	// Assign initial state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: if (s) begin next_state = B; end else begin next_state = A; end
			B: if (w) begin next_state = S11; end else begin next_state = S10; end
			C: if (w) begin next_state = S11; end else begin next_state = S10; end
			S10: if (w) begin next_state = S21; end else begin next_state = S20; end
			S11: if (w) begin next_state = S22; end else begin next_state = S21; end
			S20: next_state = B;
			S21: if (w) begin next_state = C; end else begin next_state = B; end
			S22: if (w) begin next_state = B; end else begin next_state = C; end
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			z <= 0;
		end else begin
			case (state)
				A: z <= 0;
				B: z <= 0;
				C: z <= 0;
				default: z <= 1;
			endcase
		end
	end

endmodule
