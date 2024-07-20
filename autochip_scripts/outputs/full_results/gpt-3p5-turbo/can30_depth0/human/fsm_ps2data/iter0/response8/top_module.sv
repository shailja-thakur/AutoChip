module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] byte_count;
	reg [7:0] first_byte;
	reg [7:0] second_byte;
	reg [7:0] third_byte;
	reg [2:0] state;
	reg [23:0] temp_out_bytes;
	
	always @(posedge clk) begin
		if (reset) begin
			byte_count <= 0;
			first_byte <= 0;
			second_byte <= 0;
			third_byte <= 0;
			state <= 0;
			done <= 0;
		end else begin
			byte_count <= byte_count + 1;
			
			case (state)
				0: begin
					if (in[3] == 1) begin
						first_byte <= in;
						state <= 1;
					end
				end
				1: begin
					second_byte <= in;
					state <= 2;
				end
				2: begin
					third_byte <= in;
					state <= 3;
				end
				3: begin
					temp_out_bytes <= {third_byte, second_byte, first_byte};
					state <= 0;
					done <= 1;
				end
				default: state <= 0;
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 0;
		end else begin
			if (done) begin
				out_bytes <= temp_out_bytes;
			end
		end
	end
endmodule
