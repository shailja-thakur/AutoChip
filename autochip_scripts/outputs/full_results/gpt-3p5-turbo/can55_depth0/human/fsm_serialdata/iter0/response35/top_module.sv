module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data_byte;
reg [2:0] count;

parameter IDLE = 3'd0;
parameter START_BIT = 3'd1;
parameter DATA_BITS = 3'd2;
parameter STOP_BIT = 3'd3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data_byte <= 8'b0;
		count <= 3'b0;
	end else begin
		case (state)
			IDLE:
				if (in == 1'b0) begin
					state <= START_BIT;
					count <= 3'b0;
				end
			START_BIT:
				if (count < 3'd7) begin
					state <= DATA_BITS;
					data_byte <= {in, data_byte[7:1]};
					count <= count + 1;
				end else begin
					state <= STOP_BIT;
					count <= 3'b0;
				end
			DATA_BITS:
				if (count < 3'd7) begin
					state <= DATA_BITS;
					data_byte <= {in, data_byte[7:1]};
					count <= count + 1;
				end else begin
					state <= STOP_BIT;
					count <= 3'b0;
				end
			STOP_BIT:
				if (count < 3'd7) begin
					if (in == 1'b1) begin
						out_byte <= data_byte;
						done <= 1'b1;
						state <= START_BIT;
					end else begin
						state <= STOP_BIT;
					end
					count <= count + 1;
				end else begin
					state <= IDLE;
					count <= 3'b0;
				end
		endcase
	end
end

endmodule
