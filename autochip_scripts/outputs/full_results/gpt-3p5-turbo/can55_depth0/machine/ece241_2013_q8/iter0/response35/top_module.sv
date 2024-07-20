module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define the states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;

	// Declare state and next_state signals
	reg [1:0] state;
	reg [1:0] next_state;

	// Assign initial state
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end

	// Assign next_state based on current state and input x
	always @(state, x) begin
		case(state)
			S: begin
				if (x) begin
					next_state <= S1;
				end else begin
					next_state <= S;
				end
			end
			S1: begin
				if (x) begin
					next_state <= S1;
				end else begin
					next_state <= S10;
				end
			end
			S10: begin
				if (x) begin
					next_state <= S1;
				end else begin
					next_state <= S;
				end
			end
			default: next_state <= S;
		endcase
	end

	// Assign output z based on current state
	always @(state, x) begin
		case(state)
			S, S1: z <= 0;
			S10: z <= x;
		endcase
	end

endmodule
