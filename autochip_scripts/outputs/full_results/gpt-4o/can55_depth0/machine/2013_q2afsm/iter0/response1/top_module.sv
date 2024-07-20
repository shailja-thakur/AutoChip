module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// Define the states
	typedef enum reg [1:0] {
		state_A = 2'b00,
		state_B = 2'b01,
		state_C = 2'b10,
		state_D = 2'b11
	} state_t;
	
	reg [1:0] state, next;

	// State register update
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= state_A;
		else
			state <= next;
	end

	// Next state logic
	always @(*) begin
		case (state)
			state_A: begin
				if (r[1])
					next = state_B;
				else if (r[2])
					next = state_C;
				else if (r[3])
					next = state_D;
				else
					next = state_A;
			end

			state_B: begin
				if (r[1])
					next = state_B;
				else
					next = state_A;
			end

			state_C: begin
				if (r[2])
					next = state_C;
				else
					next = state_A;
			end

			state_D: begin
				if (r[3])
					next = state_D;
				else
					next = state_A;
			end

			default: next = state_A;
		endcase
	end

	// Output logic
	always @(*) begin
		g = 3'b000; // Default value
		case (state)
			state_B: g[1] = 1'b1;
			state_C: g[2] = 1'b1;
			state_D: g[3] = 1'b1;
			default: g = 3'b000;
		endcase
	end

endmodule
