module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

localparam START_BIT = 1'b0;
localparam STOP_BIT = 1'b1;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		bit_count <= 0;
		data_reg <= 0;
		out_byte <= 0;
		done <= 0;
	end
	else begin
		case (state)
			0: // IDLE
				if (in == START_BIT) begin
					state <= 1;
					bit_count <= 0;
					data_reg <= 0;
				end
			1: // RECEIVE_DATA
				if (bit_count < 8) begin
					data_reg[bit_count] <= in;
					bit_count <= bit_count + 1;
				end
				else if (in == STOP_BIT) begin
					out_byte <= data_reg;
					done <= 1;
					state <= 0;
				end
				else begin
					state <= 2; // Wait for stop bit
					bit_count <= 0;
				end
			2: // WAIT_FOR_STOP_BIT
				if (in == STOP_BIT) begin
					state <= 0;
					done <= 1;
				end
		endcase
	end
end

endmodule
