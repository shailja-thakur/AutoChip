module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

	reg [2:0] state;
	reg [2:0] next_state;
	reg [7:0] data_byte;
	reg start_bit_detected;
	reg stop_bit_detected;
	reg [2:0] bit_count;

	parameter IDLE = 3'd0;
	parameter START_BIT = 3'd1;
	parameter DATA_BITS = 3'd2;
	parameter STOP_BIT = 3'd3;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data_byte <= 8'b0;
			start_bit_detected <= 0;
			stop_bit_detected <= 0;
			bit_count <= 0;
			out_byte <= 0;
			done <= 0;
		end
		else begin
			state <= next_state;
			data_byte <= {data_byte[6:0], in};
			start_bit_detected <= 0;
			stop_bit_detected <= 0;

			case (state)
				IDLE: begin
					if (in == 0) begin
						next_state <= START_BIT;
						start_bit_detected <= 1;
						bit_count <= 0;
					end
					else begin
						next_state <= IDLE;
					end
				end
				START_BIT: begin
					next_state <= DATA_BITS;
				end
				DATA_BITS: begin
					if (bit_count == 7) begin
						next_state <= STOP_BIT;
						bit_count <= 0;
					end
					else begin
						next_state <= DATA_BITS;
						bit_count <= bit_count + 1;
					end
				end
				STOP_BIT: begin
					if (bit_count == 0 && in == 1) begin
						next_state <= IDLE;
						stop_bit_detected <= 1;
						out_byte <= data_byte;
						done <= 1;
					end
					else if (bit_count == 7 && in == 0) begin
						next_state <= START_BIT;
						start_bit_detected <= 1;
						bit_count <= 0;
					end
					else begin
						next_state <= STOP_BIT;
						bit_count <= bit_count + 1;
					end
				end
				default: begin
					next_state <= IDLE;
				end
			endcase
		end
	end

endmodule
