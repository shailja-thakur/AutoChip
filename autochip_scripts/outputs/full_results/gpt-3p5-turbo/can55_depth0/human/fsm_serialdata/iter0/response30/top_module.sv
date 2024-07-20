module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data_byte;
reg [2:0] bit_count;

parameter START_BIT = 3'b000;
parameter DATA_BITS = 3'b001;
parameter STOP_BIT = 3'b010;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= START_BIT;
		data_byte <= 8'b0;
		bit_count <= 3'b0;
		out_byte <= 8'b0;
		done <= 0;
	end else begin
		case (state)
			START_BIT: begin
				if (in == 0) begin
					state <= DATA_BITS;
					bit_count <= 3'b1;
				end
			end
			
			DATA_BITS: begin
				data_byte[bit_count] <= in;
				if (bit_count == 3'b100) begin
					state <= STOP_BIT;
					bit_count <= 3'b0;
				end else begin
					bit_count <= bit_count + 1;
				end
			end
			
			STOP_BIT: begin
				if (in == 1) begin
					out_byte <= data_byte;
					done <= 1;
					state <= START_BIT;
				end
			end
		endcase
	end
end

endmodule
