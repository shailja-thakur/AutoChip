module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);
	reg [1:0] state;
	reg [1:0] next_state;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= 2'b00; // state A
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			2'b00: begin // state A
				f <= 1'b0;
				if (~resetn)
					next_state = 2'b00;
				else if (x == 1'b1)
					next_state = 2'b01; // transition to state B
				else
					next_state = 2'b00;
			end
			2'b01: begin // state B
				f <= 1'b1;
				if (x == 1'b0)
					next_state = 2'b01; // stay in state B
				else if (x == 1'b1)
					next_state = 2'b10; // transition to state C
			end
			2'b10: begin // state C
				if (x == 1'b0)
					next_state = 2'b01; // transition back to state B
				else if (y == 1'b1)
					next_state = 2'b11; // transition to state D
				else
					next_state = 2'b10; // stay in state C
			end
			2'b11: begin // state D
				if (y == 1'b1)
					next_state = 2'b11; // stay in state D
				else
					next_state = 2'b01; // transition back to state B
			end
		endcase
	end
	
	always @(state) begin
		case (state)
			2'b00: g <= 1'b0; // g = 0 in state A
			2'b01: g <= 1'b0; // g = 0 in state B
			2'b10: g <= 1'b1; // g = 1 in state C
			2'b11: g <= 1'b1; // g = 1 in state D
		endcase
	end
	
endmodule
