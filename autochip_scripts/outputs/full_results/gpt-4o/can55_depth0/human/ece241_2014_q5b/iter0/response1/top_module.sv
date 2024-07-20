module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State declarations using one-hot encoding
	reg [1:0] state, next_state;
	localparam A = 2'b01, B = 2'b10;

	// Asynchronous reset to state A
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (x) next_state = B;
				else next_state = A;
			end
			B: begin
				next_state = B;
			end
			default: next_state = A; // Reset to a known state
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			A: z = x;
			B: z = ~x;
			default: z = 0;
		endcase
	end

endmodule
