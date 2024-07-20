module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	// Adding a reg to hold the current state
	reg [2:0] current_state;
	
	always @(posedge clk) begin
		// Assigning the current state to the next state at the positive edge of the clock
		current_state <= next_state;
	end
	
	reg [2:0] next_state;
	always @(posedge clk) begin
		case ({x, current_state})
			3'b000: next_state <= 3'b000;
			3'b001: next_state <= 3'b100;
			3'b010: next_state <= 3'b001;
			3'b011: next_state <= 3'b010;
			3'b100: next_state <= 3'b100;
		endcase
	end

	always @(posedge clk) begin
		case (current_state)
			3'b000: begin
				Y0 <= 1'b0;
				z <= 1'b0;
			end
			3'b001: begin
				Y0 <= 1'b0;
				z <= 1'b0;
			end
			3'b010: begin
				Y0 <= 1'b0;
				z <= 1'b0;
			end
			3'b011: begin
				Y0 <= 1'b0;
				z <= 1'b1;
			end
			3'b100: begin
				Y0 <= 1'b1;
				z <= 1'b1;
			end
		endcase
	end
endmodule
