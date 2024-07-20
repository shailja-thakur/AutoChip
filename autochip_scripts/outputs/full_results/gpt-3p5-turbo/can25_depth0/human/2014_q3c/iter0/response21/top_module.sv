module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

// FSM state assignments
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

reg [2:0] next_state;

always @(posedge clk) begin
	// State transition logic
	case(y)
		S0: begin
			if (x == 0)
				next_state = S0;
			else if (x == 1)
				next_state = S1;
		end

		S1: begin
			if (x == 0)
				next_state = S1;
			else if (x == 1)
				next_state = S4;
		end

		S2: begin
			if (x == 0)
				next_state = S2;
			else if (x == 1)
				next_state = S1;
		end

		S3: begin
			if (x == 0)
				next_state = S1;
			else if (x == 1)
				next_state = S2;
		end

		S4: begin
			if (x == 0)
				next_state = S3;
			else if (x == 1)
				next_state = S4;
		end
	endcase

	// Output assignment logic
	Y0 <= next_state[0];
	z <= (next_state == S3 || next_state == S4) ? 1'b1 : 1'b0;
end

endmodule
