module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg data_valid;
reg start_bit_found;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data <= 8'b0;
		data_valid <= 1'b0;
		start_bit_found <= 1'b0;
	end else begin
		case(state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
					start_bit_found <= 1'b1;
				end
			end
			START_BIT: begin
				if (in == 1'b0) begin
					state <= DATA_BITS;
					data <= in;
					data_valid <= 1'b0;
				end else begin
					state <= IDLE;
					start_bit_found <= 1'b0;
				end
			end
			DATA_BITS: begin
				data <= {data[6:0], in};
				if (data_valid) begin
					state <= STOP_BIT;
				end
				data_valid <= 1'b1;
			end
			STOP_BIT: begin
				if (in == 1'b1 && start_bit_found) begin
					state <= IDLE;
					done <= 1'b1;
					out_byte <= data;
				end else begin
					state <= STOP_BIT;
				end
			end
			default: state <= IDLE;
		endcase
	end
end

endmodule
