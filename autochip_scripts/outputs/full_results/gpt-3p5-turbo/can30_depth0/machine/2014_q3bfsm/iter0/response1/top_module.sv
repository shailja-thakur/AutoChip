module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;  // Initialize state to A
		else
			state <= next_state;
	end

	always @* begin
		case (state)
			3'b000: begin  // A
				if (x)
					next_state = 3'b001;  // B
				else
					next_state = 3'b000;  // A
			end

			3'b001: begin  // B
				if (x)
					next_state = 3'b100;  // E
				else
					next_state = 3'b001;  // B
			end

			3'b010: begin  // C
				if (x)
					next_state = 3'b001;  // B
				else
					next_state = 3'b010;  // C
			end

			3'b011: begin  // D
				if (x)
					next_state = 3'b010;  // C
				else
					next_state = 3'b001;  // B
			end

			3'b100: begin  // E
				if (x)
					next_state = 3'b100;  // E
				else
					next_state = 3'b011;  // D
			end

			default: next_state = 3'b000;  // Default to A
		endcase
	end

	always @(posedge clk) begin
		if (state == 3'b100 || state == 3'b101)
			z <= 1'b1;
		else
			z <= 1'b0;
	end

endmodule
