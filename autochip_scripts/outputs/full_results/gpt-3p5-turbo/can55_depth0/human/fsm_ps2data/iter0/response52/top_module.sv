module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	
	reg [23:0] shift_reg;
	reg [3:0] byte_count;
	reg [23:0] temp_out_bytes;
	reg done;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 0;
			byte_count <= 0;
			temp_out_bytes <= 0;
			done <= 0;
		end else begin
			if (byte_count == 0 && in[3] == 1) begin
				shift_reg <= in;
				byte_count <= 1;
				temp_out_bytes <= 0;
			end else if (byte_count == 1) begin
				shift_reg <= {shift_reg[15:0], in};
				byte_count <= 2;
			end else if (byte_count == 2) begin
				shift_reg <= {shift_reg[7:0], in};
				byte_count <= 3;
			end else begin
				shift_reg <= {shift_reg[7:0], in};
			end
			
			if (byte_count == 3) begin
				temp_out_bytes <= shift_reg;
				byte_count <= 0;
				done <= 1;
			end else begin
				temp_out_bytes <= 0;
				done <= 0;
			end 
		end
	end
	
	assign out_bytes = temp_out_bytes;
endmodule
