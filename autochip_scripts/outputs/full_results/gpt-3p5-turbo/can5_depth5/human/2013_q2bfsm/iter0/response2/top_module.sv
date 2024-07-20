module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
	reg [1:0] state;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= 2'b00; // state A
		else begin
			case (state)
				2'b00: begin // state A
					state <= 2'b01; // transition to state B
					f <= 1'b0; // reset f
				end
				2'b01: begin // state B
					if (x == 1'b1)
						state <= 2'b10; // transition to state C
				end
				2'b10: begin // state C
					if (x == 1'b0)
						state <= 2'b01; // transition back to state B
					else if (y == 1'b1)
						state <= 2'b11; // transition to state D
				end
				2'b11: begin // state D
					if (y != 1'b1)
						state <= 2'b01; // transition back to state B
				end
			endcase
		end
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
