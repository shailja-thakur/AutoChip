module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	localparam A = 1'b0, B = 1'b1;
	
	// Current state and next state variables
	reg current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			A: next_state = (in) ? A : B;
			B: next_state = (in) ? B : A;
			default: next_state = B;
		endcase
	end

	// State register logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= B;
		end else begin
			current_state <= next_state;
		end
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			out <= 1'b1;
		end else begin
			out <= (current_state == B) ? 1'b1 : 1'b0;
		end
	end
	
endmodule
