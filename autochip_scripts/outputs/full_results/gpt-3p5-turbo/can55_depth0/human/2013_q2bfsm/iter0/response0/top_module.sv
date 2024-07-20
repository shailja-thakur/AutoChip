module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg [2:0] state, next_state;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= 3'b000;
		else
			state <= next_state;
	end
	
	always @(state or x or y) begin
		case (state)
			// Beginning state, output f is 0
			3'b000: begin
				f <= 1'b0;
				g <= 1'b0;
				if (~resetn && (x == 1'b1))
					next_state <= 3'b001;
				else
					next_state <= state;
			end
			
			// Setting output f to 1 for one clock cycle
			3'b001: begin
				f <= 1'b1;
				g <= 1'b0;
				next_state <= 3'b010;
			end
			
			// Monitoring x input
			3'b010: begin
				if (x == 1'b1)
					next_state <= 3'b011;
				else
					next_state <= state;
			end
			
			// Monitoring x input for three successive clock cycles
			3'b011: begin
				if (x == 1'b0)
					next_state <= 3'b100;
				else
					next_state <= state;
			end
			
			// Setting output g to 1 on the following clock cycle
			3'b100: begin
				g <= 1'b1;
				next_state <= 3'b101;
			end
			
			// Maintaining g = 1 and monitoring y input
			3'b101: begin
				if (y == 1'b1)
					next_state <= 3'b101;
				else if (y == 1'b0)
					next_state <= 3'b110;
				else
					next_state <= state;
			end
			
			// Checking if y becomes 1 within at most two clock cycles
			3'b110: begin
				if (y == 1'b1)
					next_state <= 3'b111;
				else if (y == 1'b0)
					next_state <= 3'b000;
				else
					next_state <= state;
			end
			
			// Maintaining g = 1 permanently
			3'b111: begin
				g <= 1'b1;
				next_state <= 3'b111;
			end
		endcase
	end
endmodule
