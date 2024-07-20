module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// Define state encoding
	reg [2:0] state, next_state;

	// State transitions
	always @(*) begin
		case (state)
			3'b000: begin
				if (x == 1)
					next_state = 3'b001;
				else
					next_state = 3'b000;
				z = 0;
			end
			3'b001: begin
				if (x == 1)
					next_state = 3'b100;
				else
					next_state = 3'b001;
				z = 0;
			end
			3'b010: begin
				if (x == 1)
					next_state = 3'b001;
				else
					next_state = 3'b010;
				z = 0;
			end
			3'b011: begin
				if (x == 1)
					next_state = 3'b010;
				else
					next_state = 3'b001;
				z = 1;
			end
			3'b100: begin
				if (x == 1)
					next_state = 3'b100;
				else
					next_state = 3'b011;
				z = 1;
			end
			default: begin
				next_state = 3'b000;
				z = 0;
			end
		endcase
	 end

	// Sequential logic for state transition
	always @(posedge clk) begin
		if (reset) 
			state <= 3'b000;
		else
			state <= next_state;
	end

endmodule
