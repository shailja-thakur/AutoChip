module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// State encoding
	typedef enum logic [1:0] {
		LOW = 2'b00,
		MID = 2'b01,
		HIGH = 2'b10,
		MAX = 2'b11
	} state_t;

	reg [1:0] current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			LOW: begin
				if (s[1]) next_state = MID;
				else next_state = LOW;
			end

			MID: begin
				if (s[2]) next_state = HIGH;
				else if (!s[1]) next_state = LOW;
				else next_state = MID;
			end

			HIGH: begin
				if (s[3]) next_state = MAX;
				else if (!s[2]) next_state = MID;
				else next_state = HIGH;
			end

			MAX: begin
				if (!s[3]) next_state = HIGH;
				else next_state = MAX;
			end

			default: next_state = LOW;
		endcase
	end

	// State flip-flop
	always @(posedge clk or posedge reset) begin
		if (reset) current_state <= LOW;
		else current_state <= next_state;
	end

	// Output logic
	always @(*) begin
		// Default values
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;

		case (current_state)
			LOW: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
				dfr = 1;
			end

			MID: begin
				fr2 = 1;
				fr1 = 1;
				if (next_state == HIGH) dfr = 1;  // Open supplemental valve if rising
			end

			HIGH: begin
				fr1 = 1;
				if (next_state == MAX) dfr = 1;  // Open supplemental valve if rising
			end

			MAX: begin
				// No Flow
			end
		endcase
	end

endmodule
