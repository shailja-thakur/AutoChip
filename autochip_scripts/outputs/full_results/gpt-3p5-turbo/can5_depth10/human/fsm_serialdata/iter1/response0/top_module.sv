module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	enum [3:0] {IDLE, START, DATA, STOP} state;
	reg [2:0] counter;
	reg rx_data;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 3'd0;
			rx_data <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					if (in == 1'b0) begin
						state <= START;
						counter <= 3'd0;
						rx_data <= 1'b0;
					end
				end
				START: begin
					state <= DATA;
					counter <= 3'd0;
					rx_data <= in;
				end
				DATA: begin
					if (counter == 3'd7) begin
						state <= STOP;
						counter <= 3'd0;
						rx_data <= in;
					end else begin
						counter <= counter + 1;
						rx_data <= {rx_data[6:0], in};
					end
				end
				STOP: begin
					state <= IDLE;
					counter <= 3'd0;
					rx_data <= 1'b0;
					if (in == 1'b1) begin
						out_byte <= rx_data;
						done <= 1'b1;
					end else begin
						done <= 1'b0;
					end
				end
				default: state <= IDLE;
			endcase
		end
	end

endmodule
