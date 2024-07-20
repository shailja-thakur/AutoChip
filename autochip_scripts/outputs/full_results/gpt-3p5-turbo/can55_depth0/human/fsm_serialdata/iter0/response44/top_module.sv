module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg [3:0] bit_counter;

parameter IDLE = 0, START = 1, RECEIVE = 2, STOP = 3;

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		bit_counter <= 0;
		data <= 0;
		out_byte <= 0;
		done <= 0;
	end else begin
		case(state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START;
					bit_counter <= 0;
					data <= 0;
				end
			end
			START: begin
				bit_counter <= bit_counter + 1;
				state <= RECEIVE;
				data <= {data[6:0], in};
			end
			RECEIVE: begin
				bit_counter <= bit_counter + 1;
				if (bit_counter == 7) begin
					bit_counter <= 0;
					state <= STOP;
				end else begin
					data <= {data[6:0], in};
				end
			end
			STOP: begin
				if (bit_counter == 0 && in == 1'b1) begin
					out_byte <= data;
					done <= 1;
					state <= IDLE;
				end else begin
					bit_counter <= bit_counter + 1;
					state <= STOP;
				end
			end
		endcase
	end
end

endmodule
