module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// Define the state register and next state
	reg [1:0] state;
	reg [1:0] next_state;

	// Assign the initial state
	assign next_state = A;

	// Synchronous state update
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Combinational logic for next_state and output
	always @(*) begin
		case(state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
		endcase

		if (state == D) begin
			out = 1;
		end else begin
			out = 0;
		end
	end

endmodule
