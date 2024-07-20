module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Enumerate the states
	typedef enum logic[1:0] {
		A,
		B
	} state;

	// Define the register variables
	reg [1:0] curr_state, next_state;
	reg [1:0] count;

	// Initialize the variables
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			curr_state <= A;
			count <= 0;
		end else begin
			curr_state <= next_state;
			count <= count + 1;
		end
	end

	// Define the next state logic
	always_comb begin
		case (curr_state)
			A: begin
				if (s == 1)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (count == 2) begin
					if (w == 1)
						z = 1;
					else
						z = 0;
				end
				next_state = B;
			end
		endcase
	end

endmodule
