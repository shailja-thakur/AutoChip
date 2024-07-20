module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	reg [1:0] state, next_state;
	reg [1:0] w_count;
    
	// State definitions
	localparam [1:0] A = 2'b00,
	                 B0 = 2'b01,
	                 B1 = 2'b10,
	                 B2 = 2'b11;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state and output logic
	always @(*) begin
		// Default assignments
		next_state = state;
		z = 0;

		case (state)
			A: begin
				if (s)
					next_state = B0;
				else
					next_state = A;
			end
			B0: begin
				w_count = 0;
				if (w)
					w_count = w_count + 1;
				next_state = B1;
			end
			B1: begin
				if (w)
					w_count = w_count + 1;
				next_state = B2;
			end
			B2: begin
				if (w)
					w_count = w_count + 1;
				if (w_count == 2)
					z = 1;
				else
					z = 0;
				next_state = B0;
			end
		endcase
	end
endmodule
