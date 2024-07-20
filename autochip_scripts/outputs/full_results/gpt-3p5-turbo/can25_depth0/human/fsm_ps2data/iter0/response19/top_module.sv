module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] in_reg;
reg [1:0] state;
reg [2:0] count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		in_reg <= 8'b0;
		state <= 2'b00;
		count <= 3'b0;
		out_bytes <= 24'b0;
		done <= 0;
	end else begin
		in_reg <= in;
		
		case (state)
			2'b00: begin
					if (in_reg[3]) begin
						state <= 2'b01;
						count <= 3'b0;
						out_bytes <= {in_reg, in_reg, in_reg};
					end
				end
			2'b01: begin
					if (count < 3'b10) begin
						count <= count + 1;
					end else begin
						state <= 2'b10;
						done <= 1;
						count <= 3'b0;
					end
				end
			default: begin
						state <= 2'b00;
					end
		endcase
	end
end

endmodule
