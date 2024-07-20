module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [1:0] state, next_state;
	reg f, g;
	
	always @(posedge clk, negedge resetn) begin
		if (!resetn) begin
			state <= 2'b00; // beginning state A
			f <= 0;
			g <= 0;
		end
		else begin
			state <= next_state;
			f <= (state == 2'b01) ? 1'b1 : 1'b0;
			
			case(state)
				2'b00: if (x == 1'b1) next_state = 2'b01; else next_state = 2'b00;
				2'b01: if (x == 1'b0) next_state = 2'b10; else next_state = 2'b01;
				2'b10: if (x == 1'b1) next_state = 2'b11; else next_state = 2'b10;
				2'b11: if (y == 1'b1) next_state = 2'b11; else next_state = 2'b00;
			endcase
			
			if (state == 2'b11) g <= 1'b1;
			else g <= 1'b0;
		end
	end
	
endmodule
