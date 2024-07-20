module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

reg [2:0] state;
reg [7:0] data;
reg stop_bit;
reg start_received;
reg [2:0] bit_count;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data <= 8'b0;
		stop_bit <= 1'b0;
		start_received <= 1'b0;
		bit_count <= 3'b0;
		done <= 1'b0;
	end
	else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
					start_received <= 1'b1;
					bit_count <= 3'b0;
				end
				else
					state <= IDLE;
			end

			START_BIT: begin
				if (bit_count == 3'b111)
					state <= DATA_BITS;
				else
					state <= START_BIT;
				bit_count <= bit_count + 1;
			end

			DATA_BITS: begin
				data <= {data[6:0], in};
				if (bit_count == 3'b111)
					state <= STOP_BIT;
				else
					state <= DATA_BITS;
				bit_count <= bit_count + 1;
			end

			STOP_BIT: begin
				if (in == 1'b1)
					state <= IDLE;
				else
					state <= STOP_BIT;
				bit_count <= bit_count + 1;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == STOP_BIT && in == 1'b1 && start_received)
		done <= 1'b1;
	else
		done <= 1'b0;
end

endmodule
