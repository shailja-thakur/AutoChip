module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define state parameters
	parameter A = 1'b0, B = 1'b1;
	
	reg state, next_state;

	// Combinational logic block to determine next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = A;
		endcase
	end

	// Sequential logic block to update the state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(state) begin
		if (state == B) begin
			out = 1'b1;
		end else begin
			out = 1'b0;
		end
	end

endmodule
