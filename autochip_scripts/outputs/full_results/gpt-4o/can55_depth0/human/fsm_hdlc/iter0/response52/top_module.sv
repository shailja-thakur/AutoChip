module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum reg [3:0] {
		S0,  // Waiting for the first 0
		S1,  // Got 0, waiting for the first 1
        S2,  // 0 -> 1
        S3,  // 01 -> 1
        S4,  // 011 -> 1
        S5,  // 0111 -> 1
        S6,  // 01111 -> 1
        S7,  // 011111 -> 1
        S8   // 0111111 -> 0
	} state_t;

	state_t state, next_state;

	// Sequential block (state transitions)
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Combinational block (next state logic)
	always @(*) begin
		// Default values for outputs
		next_state = state;
		disc = 0;
		flag = 0;
		err = 0;
		case(state)
			S0: begin
				if (in == 1'b0)
					next_state = S1;
			end
			S1: begin
				if (in == 1'b1)
					next_state = S2;
				else
					next_state = S1;
			end
			S2: begin
				if (in == 1'b1)
					next_state = S3;
				else
					next_state = S1;
			end
			S3: begin
				if (in == 1'b1)
					next_state = S4;
				else
					next_state = S1;
			end
			S4: begin
				if (in == 1'b1)
					next_state = S5;
				else
					next_state = S1;
			end
			S5: begin
				if (in == 1'b1)
					next_state = S6;
				else
					next_state = S1;
			end
			S6: begin
				if (in == 1'b1)
					next_state = S7;
				else begin
					next_state = S1;
					disc = 1;
				end
			end
			S7: begin
				if (in == 1'b1) begin
					next_state = S8;
					err = 1;
				end
				else begin
					next_state = S1;
					flag = 1;
				end
			end
			S8: begin
				if (in == 1'b1) begin
					next_state = S8;
					err = 1;
				end else
					next_state = S1;
			end
			default: next_state = S0;
		endcase
	end
endmodule
