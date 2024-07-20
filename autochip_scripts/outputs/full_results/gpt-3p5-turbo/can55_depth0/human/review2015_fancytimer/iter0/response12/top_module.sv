module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	// Internal signals and registers
	reg [2:0] state;
	reg [3:0] delay;
	reg [9:0] counter;
	reg [3:0] remaining_time;
	reg start;
	reg [3:0] shift_reg;

	// Reset state
	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
			delay <= 4'b0000;
			counter <= 10'b0;
			remaining_time <= 4'b0000;
			start <= 1'b0;
			shift_reg <= 4'b0000;
			counting <= 1'b0;
			done <= 1'b0;
		end else begin
			case (state)
				3'b000: begin // Search for input sequence
					if (data) begin
						shift_reg <= {shift_reg[2:0], data};
						if (shift_reg == 4'b1101) begin
							state <= 3'b001; // Found input sequence, move to next state
							start <= 1'b1;
						end
					end
				end
				3'b001: begin // Shift in delay bits
					shift_reg <= {shift_reg[2:0], data};
					delay <= shift_reg;
					count @ 1'b0;
					state <= 3'b010; // Move to next state
				end
				3'b010: begin // Start counting
					counting <= 1'b1;
					counter <= 10'b0;
					state <= 3'b011; // Move to next state
				end
				3'b011: begin // Counting
					if (counter == ((delay + 1) * 1000 - 1)) begin
						counter <= 10'b0;
						remaining_time <= remaining_time - 1;
					end else if (counter == (delay + 1) * 1000) begin
						counter <= 10'b0;
						remaining_time <= remaining_time - 1;
						delay <= delay - 1;
						if (delay == 4'b0000) begin
							state <= 3'b100; // Delay completed, move to next state
							counting <= 1'b0;
							done <= 1'b1;
						end else begin
							state <= 3'b010; // Continue counting
						end
					end else begin
						counter <= counter + 1;
					end
				end
				3'b100: begin // Wait for ack and reset
					if (ack) begin
						state <= 3'b000; // Reset to initial state
						start <= 1'b0;
						done <= 1'b0;
					end
				end
			endcase
		end
	end

	assign count = counting ? remaining_time : 4'b0000;

endmodule
