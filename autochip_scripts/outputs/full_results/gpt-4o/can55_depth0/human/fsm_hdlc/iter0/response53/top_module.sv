module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err
);

	typedef enum reg [2:0] {
		S0, // Initial state
		S1, // Saw 0
		S2, // Saw 01
		S3, // Saw 011
		S4, // Saw 0111
		S5, // Saw 01111
		S6, // Saw 011111
		S7, // Saw 0111111 (discard)
		S8, // Saw 01111110 (flag)
		S9  // Saw 01111111+ (error)
	} state_t;

	state_t state, next_state;

	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	always @(*) begin
		next_state = state;
		disc = 0;
		flag = 0;
		err = 0;
		case (state)
			S0: next_state = in ? S0 : S1;
			S1: next_state = in ? S2 : S1;
			S2: next_state = in ? S3 : S1;
			S3: next_state = in ? S4 : S1;
			S4: next_state = in ? S5 : S1;
			S5: next_state = in ? S6 : S1;
			S6: begin
				next_state = in ? S7 : S8;
			end
			S7: begin
				next_state = in ? S9 : S1;
				disc = 1;
			end
			S8: begin
				next_state = in ? S2 : S1;
				flag = 1;
			end
			S9: begin
				next_state = in ? S9 : S1;
				err = 1;
			end
		endcase
	end
endmodule
