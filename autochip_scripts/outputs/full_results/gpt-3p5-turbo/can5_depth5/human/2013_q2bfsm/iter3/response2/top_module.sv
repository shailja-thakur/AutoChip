module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
	reg [1:0] state;
	reg [2:0] x_history;
	reg [1:0] y_timer;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 2'b00; // state A
            f <= 1'b0; // reset f
			g <= 1'b0; // reset g
			x_history <= 3'b000; // reset x_history
			y_timer <= 2'b00; // reset y_timer
		end
		else begin
			case (state)
				2'b00: begin // state A
					if (resetn == 1'b1)
						state <= 2'b01; // transition to state B
				end
				2'b01: begin // state B
					f <= 1'b1; // set f to 1 for one clock cycle
					state <= 2'b10; // transition to state C
				end
				2'b10: begin // state C
					if (x == 1'b0)
						state <= 2'b01; // transition back to state B
					else if (x_history == 3'b101) begin
						state <= 2'b11; // transition to state D
						y_timer <= 2'b00; // reset y_timer
					end
				end
				2'b11: begin // state D
					if (y == 1'b1)
						g <= 1'b1; // set g = 1
						
					if (y_timer == 2'b11)
						g <= 1'b0; // set g = 0 permanently
						
					if (y == 1'b0)
						y_timer <= y_timer + 1'b1; // increment y_timer
					else
						y_timer <= 2'b00; // reset y_timer
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		x_history <= {x_history[1:0], x}; // shift in new x value
	end
	
endmodule
