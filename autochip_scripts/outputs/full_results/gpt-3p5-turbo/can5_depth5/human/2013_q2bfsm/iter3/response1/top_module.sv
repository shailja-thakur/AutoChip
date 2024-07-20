module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
	reg [1:0] state;
	reg [1:0] x_history;
	reg [1:0] y_timer;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 2'b00; // state A
			f <= 1'b0; // reset f
			g <= 1'b0; // reset g
		end
		else begin
			case (state)
				2'b00: begin // state A
					f <= 1'b0; // reset f
					if (resetn == 1'b1)
						state <= 2'b01; // transition to state B
				end
				2'b01: begin // state B
					if (x == 1'b1) begin
						state <= 2'b10; // transition to state C
						x_history <= 2'b00; // reset x_history
					end
				end
				2'b10: begin // state C
					if (x == 1'b0) begin
						state <= 2'b01; // transition back to state B
						x_history <= 2'b00; // reset x_history
					end
					else begin
						x_history <= {x_history[0], x}; // keep track of previous x values
						if (x_history == 2'b101) begin
							state <= 2'b11; // transition to state D
							y_timer <= 2'b00; // reset y_timer
						end
					end
				end
				2'b11: begin // state D
					if (y == 1'b1) begin
						g <= 1'b1; // set g = 1
						y_timer <= 2'b00; // reset y_timer
					end
					else if (y_timer < 2'b11) begin
						y_timer <= y_timer + 2'b01; // increment y_timer
					end
					else begin
						g <= 1'b0; // set g = 0
					end
				end
			endcase
		end
	end
	
endmodule
