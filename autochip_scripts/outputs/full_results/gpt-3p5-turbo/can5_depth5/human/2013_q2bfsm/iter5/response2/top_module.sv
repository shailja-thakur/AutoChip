module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
	reg [1:0] state;
	reg [2:0] history;
	reg [1:0] y_timer;
	// Add output reg g_buffer to hold previous value of g
	reg g_buffer;

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 2'b00; // state A
			f <= 1'b0; // reset f
			g <= 1'b0; // reset g
			history <= 3'b000; // reset history
			y_timer <= 2'b00; // reset y_timer
		end
		else begin
			case (state)
				2'b00: begin // state A
					f <= 1'b0; // reset f
					if (resetn == 1'b1)
						state <= 2'b01; // transition to state B
				end
				2'b01: begin // state B
					if (x == 1'b1)
						state <= 2'b10; // transition to state C
				end
				2'b10: begin // state C
					if (x == 1'b0)
						state <= 2'b01; // transition back to state B
					else if (history == 3'b101) begin
						state <= 2'b11; // transition to state D
						y_timer <= 2'b00; // reset y_timer
					end
				end
				2'b11: begin // state D
					if (y == 1'b1)
						g <= 1'b1; // set g = 1
					else if (y_timer == 2'b11)
						g <= 1'b0; // set g = 0
				end
			endcase
		end
	end

	always @(posedge clk) begin
        // Store previous value of g in g_buffer
        g_buffer <= g;
		history <= {history[1:0], x}; // shift in new x value
		if (state == 2'b11 && g_buffer == 1'b1)
			y_timer <= 2'b00; // reset y_timer
		else if (y_timer < 2'b11)
			y_timer <= y_timer + 1'b1; // increment y_timer
	end

endmodule
