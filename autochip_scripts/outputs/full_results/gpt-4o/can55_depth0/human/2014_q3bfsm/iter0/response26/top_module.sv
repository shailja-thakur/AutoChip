module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// FSM state encoding
	typedef enum logic [2:0] {
		S0 = 3'b000,
		S1 = 3'b001,
		S2 = 3'b010,
		S3 = 3'b011,
		S4 = 3'b100
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic and output logic
	always_comb begin
		case (state)
			S0: begin
				if (x) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
				z = 0;
			end
			S1: begin
				if (x) begin
					next_state = S4;
				end else begin
					next_state = S1;
				end
				z = 0;
			end
			S2: begin
				if (x) begin
					next_state = S1;
				end else begin
					next_state = S2;
				end
				z = 0;
			end
			S3: begin
				if (x) begin
					next_state = S2;
				end else begin
					next_state = S1;
				end
				z = 1;
			end
			S4: begin
				if (x) begin
					next_state = S4;
				end else begin
					next_state = S3;
				end
				z = 1;
			end
			default: begin
				next_state = S0;
				z = 0;
			end
		endcase
	end

endmodule
