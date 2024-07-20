module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	
	parameter START = 0;
	parameter RECEIVE = 1;
	parameter CHECK_STOP = 2;
	
	reg [2:0] state;
	reg [7:0] data_bits;
	reg start_bit;
	reg stop_bit;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= START;
			data_bits <= 8'b0;
			start_bit <= 1'b0;
			stop_bit <= 1'b0;
		end else begin
			case (state)
				START: begin
					if (in == 1'b0) begin
						state <= RECEIVE;
						start_bit <= in;
						data_bits <= 8'b0;
					end else begin
						start_bit <= in;
					end
				end
				RECEIVE: begin
					data_bits <= {data_bits[6:0], in};
					if (stop_bit == 1'b0) begin
						state <= CHECK_STOP;
					end
				end
				CHECK_STOP: begin
					if (in == 1'b1) begin
						stop_bit <= in;
						if (stop_bit == 1'b1) begin
							out_byte <= data_bits;
							state <= START;
							done <= 1'b1;
						end else begin
							state <= CHECK_STOP;
						end
					end
				end
				default: begin
					state <= START;
					data_bits <= 8'b0;
					start_bit <= 1'b0;
					stop_bit <= 1'b0;
				end
			endcase
		end
	end
	
endmodule
