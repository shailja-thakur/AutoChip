module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	reg [3:0] delay;
	reg [3:0] current_delay;
	reg [2:0] state;

	always @(posedge clk) begin
		if (reset) begin
			counting <= 0;
			done <= 0;
			state <= 0;
		end else begin
			case (state)
				0: begin // Searching for start sequence
					if (data == 4'b1101) begin
						delay <= data;
						state <= 1;
					end
				end
				1: begin // Shifting in delay bits
					delay <= {delay[2:0], data};
					state <= 2;
				end
				2: begin // Counting state
					counting <= 1;
					if (current_delay < delay) begin
						current_delay <= current_delay + 1;
					end else begin
						current_delay <= 0;
						state <= 3;
					end
				end
				3: begin // Done state
					counting <= 0;
					done <= 1;
					if (ack) begin
						state <= 0;
					end
				end
				default: state <= 0;
			endcase
		end
	end

	assign count = current_delay;

endmodule
