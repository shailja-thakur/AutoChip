module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [3:0] state;
reg [7:0] data_reg;

parameter IDLE = 4'd0;
parameter START_BIT = 4'd1;
parameter DATA_BITS = 4'd2;
parameter STOP_BIT = 4'd3;
parameter DONE = 4'd4;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data_reg <= 8'b0;
		out_byte <= 8'b0;
		done <= 1'b0;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
				end
			end
			START_BIT: begin
				if (in == 1'b0) begin
					state <= DATA_BITS;
				end else begin
					state <= IDLE;
				end
			end
			DATA_BITS: begin
				if (in == 1'b0) begin
					data_reg <= {data_reg[6:0], in};
				end else begin
					state <= STOP_BIT;
				end
			end
			STOP_BIT: begin
				if (in == 1'b1) begin
					out_byte <= data_reg;
					done <= 1'b1;
					state <= DONE;
				end else begin
					state <= IDLE;
				end
			end
			DONE: begin
				state <= IDLE;
				done <= 1'b0;
			end
		endcase
	end
end

endmodule
