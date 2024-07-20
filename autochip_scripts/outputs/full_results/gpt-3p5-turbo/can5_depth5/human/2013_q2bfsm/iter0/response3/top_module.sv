module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	reg [1:0] state;
	reg f_next;
	reg g_next;
	
	always @(posedge clk, negedge resetn) begin
		if (~resetn) begin
			state <= 2'b00; // state A (beginning state)
			f <= 0;
			g <= 0;
		end else begin
			case(state)
				2'b00: begin // state A
					if (resetn) begin
						state <= 2'b01; // transition to state B
					end
				end
				
				2'b01: begin // state B
					f_next <= 1;
					state <= 2'b10; // transition to state C
				end
				
				2'b10: begin // state C
					if (resetn) begin
						if (x === 1 && $past(x) === 0 && $past($past(x)) === 1) begin
							g_next <= 1;
							state <= 2'b11; // transition to state D
						end
					end
				end
				
				2'b11: begin // state D
					if (resetn) begin
						if (y === 1 && $past(y) === 0) begin
							g_next <= 1;
						end else begin
							g_next <= 0;
						end
						state <= 2'b11; // stay in state D
					end
				end
			endcase
		end
	end
	
	always @(posedge clk, negedge resetn) begin
		if (~resetn) begin
			f <= 0;
			g <= 0;
		end else begin
			f <= f_next;
			g <= g_next;
		end
	end
	
endmodule
