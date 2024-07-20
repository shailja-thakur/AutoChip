module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] out_bytes_reg;
	reg [23:0] next_out_bytes;
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes_reg <= 0;
			state <= 0;
		end else begin
			out_bytes_reg <= next_out_bytes;
			state <= next_state;
		end
	end
	
	assign done = (state == 3'b011);
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			next_state <= 0;
			next_out_bytes <= 0;
		end else begin
			case (state)
				3'b000: begin
					if (in[2] == 1) begin
						next_state <= 3'b001;
					end else begin
						next_state <= 3'b000;
					end
					next_out_bytes <= {out_bytes_reg[15:0], in};
				end
				3'b001: begin
					next_state <= 3'b010;
					next_out_bytes <= {out_bytes_reg[23:8], in};
				end
				3'b010: begin
					next_state <= 3'b011;
					next_out_bytes <= {out_bytes_reg[23:16], in};
				end
				3'b011: begin
					next_state <= 3'b000;
					next_out_bytes <= out_bytes_reg;
				end
			endcase
		end
	end
	
	assign out_bytes = out_bytes_reg;

endmodule
