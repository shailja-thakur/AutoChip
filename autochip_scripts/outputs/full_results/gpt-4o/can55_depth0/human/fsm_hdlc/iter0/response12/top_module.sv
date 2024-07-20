module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err
);

	reg [3:0] state, next_state;

	// State encoding
	localparam  S0 = 4'b0000,
	            S1 = 4'b0001,
	            S2 = 4'b0010,
	            S3 = 4'b0011,
	            S4 = 4'b0100,
	            S5 = 4'b0101,
	            S6 = 4'b0110,
	            S7 = 4'b0111,
	            S8 = 4'b1000,
	            S_ERR = 4'b1001;
	
	// State transition (Moore FSM)
	always @(*) begin
		case (state)
			S0: next_state = in ? S1 : S0;
			S1: next_state = in ? S2 : S0;
			S2: next_state = in ? S3 : S0;
			S3: next_state = in ? S4 : S0;
			S4: next_state = in ? S5 : S0;
			S5: next_state = in ? S6 : S0;
			S6: next_state = in ? S7 : S0;
			S7: next_state = in ? S_ERR : S0;
			S8: next_state = in ? S1 : S0;
			S_ERR: next_state = S_ERR;
			default: next_state = S0;
		endcase
	end

	// Output logic (Moore FSM Output on transition)
	always @(posedge clk) begin
		if (reset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
		disc <= 0;
		flag <= 0;
		err <= 0;

		case (state)
			S5: if (!in) disc <= 1;
			S6: if (!in) flag <= 1;
			S7: if (in) err <= 1;
		endcase
	end
endmodule
