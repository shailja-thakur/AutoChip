module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// State Encoding
	typedef enum logic [1:0] {
		LOW = 2'b00,
		MID_LOW = 2'b01,
		MID_HIGH = 2'b10,
		HIGH = 2'b11
	} state_t;

	state_t state, next_state;

	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= LOW;
		else
			state <= next_state;
	end

	always_comb begin
		// Default values
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;
		next_state = state;

		case (state)
			LOW: begin
				if (s == 3'b000) begin
					fr3 = 1;
					fr2 = 1;
					fr1 = 1;
					dfr = 0; // No need for dfr as level is consistently low
				end else if (s == 3'b001) begin
					next_state = MID_LOW;
				end else if (s == 3'b011) begin
					next_state = MID_HIGH;
				end else if (s == 3'b111) begin
					next_state = HIGH;
				end
			end
			MID_LOW: begin
				if (s == 3'b000) begin
					next_state = LOW;
					fr3 = 1;
					fr2 = 1;
					fr1 = 1;
					dfr = 0;
				end else if (s == 3'b001) begin
					fr3 = 0;
					fr2 = 1;
					fr1 = 1;
					dfr = 0; // No change in state, maintaining flow rate
				end else if (s == 3'b011) begin
					next_state = MID_HIGH;
					dfr = 1; // Supplemental flow required
				end else if (s == 3'b111) begin
					next_state = HIGH;
				end
			end
			MID_HIGH: begin
				if (s == 3'b000) begin
					next_state = LOW;
					fr3 = 1;
					fr2 = 1;
					fr1 = 1;
					dfr = 0;
				end else if (s == 3'b001) begin
					next_state = MID_LOW;
				end else if (s == 3'b011) begin
					fr3 = 0;
					fr2 = 0;
					fr1 = 1;
					dfr = 0; // No change in state, maintaining flow rate
				end else if (s == 3'b111) begin
					next_state = HIGH;
					dfr = 1; // Supplemental flow required
				end
			end
			HIGH: begin
				if (s == 3'b000) begin
					next_state = LOW;
					fr3 = 1;
					fr2 = 1;
					fr1 = 1;
					dfr = 0;
				end else if (s == 3'b001) begin
					next_state = MID_LOW;
				end else if (s == 3'b011) begin
					next_state = MID_HIGH;
				end else if (s == 3'b111) begin
					fr3 = 0;
					fr2 = 0;
					fr1 = 0;
					dfr = 0; // No change in state, flow rate to zero
				end
			end
			default: next_state = LOW;
		endcase
	end
endmodule
