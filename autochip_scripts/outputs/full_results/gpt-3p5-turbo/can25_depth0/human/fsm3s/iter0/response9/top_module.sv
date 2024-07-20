module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states
	typedef enum {
		A,
		B,
		C,
		D
	} state;

	// Define the next state and output lookup table
	reg [1:0] next_state;
	reg out;

	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			next_state <= A;
			out <= 0;
		end else begin
			case (state)
				A: begin
					if (in) begin
						next_state <= B;
					end else begin
						next_state <= A;
					end
					out <= 0;
				end
				B: begin
					if (in) begin
						next_state <= B;
					end else begin
						next_state <= C;
					end
					out <= 0;
				end
				C: begin
					if (in) begin
						next_state <= D;
					end else begin
						next_state <= A;
					end
					out <= 0;
				end
				D: begin
					if (in) begin
						next_state <= B;
					end else begin
						next_state <= C;
					end
					out <= 1;
				end
			endcase
		end
	end

	// Define the current state register
	reg [1:0] state_reg;

	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= A;
		end else begin
			state_reg <= next_state;
		end
	end

	// Assign the output
	assign out = out;

endmodule
