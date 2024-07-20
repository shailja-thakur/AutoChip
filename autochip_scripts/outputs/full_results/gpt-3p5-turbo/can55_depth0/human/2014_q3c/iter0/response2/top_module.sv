module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

// Register to store the present state
reg [2:0] present_state;
// Register to store the next state
reg [2:0] next_state;

always @(posedge clk) begin
	// Get the present state
	present_state <= y;
	
	// Determine the next state based on the present state and input x
	case (present_state)
		3'b000: begin
			if (x == 1)
				next_state <= 3'b001;
			else
				next_state <= 3'b000;
		end
		3'b001: begin
			if (x == 1)
				next_state <= 3'b100;
			else
				next_state <= 3'b001;
		end
		3'b010: begin
			if (x == 1)
				next_state <= 3'b001;
			else
				next_state <= 3'b010;
		end
		3'b011: begin
			if (x == 1)
				next_state <= 3'b010;
			else
				next_state <= 3'b001;
		end
		3'b100: begin
			if (x == 1)
				next_state <= 3'b100;
			else
				next_state <= 3'b011;
		end
	endcase
end

always @(posedge clk) begin
	// Determine the value of Y0 based on the next state
	case (next_state)
		3'b000: Y0 <= 1'b0;
		3'b001: Y0 <= 1'b0;
		3'b010: Y0 <= 1'b0;
		3'b011: Y0 <= 1'b0;
		3'b100: Y0 <= 1'b1;
	endcase
	
	// Determine the value of z based on the next state
	case (next_state)
		3'b011: z <= 1'b1;
		3'b100: z <= 1'b1;
		default: z <= 1'b0;
	endcase
end

endmodule
