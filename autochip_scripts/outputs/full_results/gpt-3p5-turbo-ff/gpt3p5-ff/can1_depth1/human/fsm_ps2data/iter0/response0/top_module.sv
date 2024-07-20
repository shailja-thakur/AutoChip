module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [1:0] state;
	reg [23:0] out_bytes_reg;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00;
			out_bytes_reg <= 24'b0;
		end else begin
			case (state)
				2'b00: begin
					if (in[3]) begin
						state <= 2'b01;
						out_bytes_reg[23:16] <= in;
					end
				end
				2'b01: state <= 2'b10;
				2'b10: begin
					if (in[3]) begin
						state <= 2'b01;
						out_bytes_reg[15:8] <= in;
					end
				end
			endcase
		end
	end
	
	assign out_bytes = (state == 2'b10) ? out_bytes_reg : 24'b0;
	assign done = (state == 2'b10);
	
endmodule
