module top_module (
	input clk,
	input reset,
	input [7:0] in,
	output done,
	output [23:0] out_bytes
);
    reg [23:0] out_bytes_reg;
    reg [3:0] state_next;
	reg [3:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes_reg <= 0;
            state <= 4'b0000;
            state_next <= 4'b0000;
		end else begin
            state <= state_next;
			
			case (state)
				4'b0000: begin
					if (in[2] == 1) begin
						state_next <= 4'b0001;
					end else begin
						out_bytes_reg <= {out_bytes_reg[15:0], in};
						state_next <= 4'b0000;
					end
				end
				4'b0001: begin
					out_bytes_reg <= {out_bytes_reg[15:0], in};
					state_next <= 4'b0010;
				end
				4'b0010: begin
					out_bytes_reg <= {out_bytes_reg[15:0], in};
					if (in[2] == 1) begin
						state_next <= 4'b0011;
					end else begin
						state_next <= 4'b0000;
					end
				end
				4'b0011: begin
					out_bytes_reg <= {out_bytes_reg[15:0], in};
					state_next <= 4'b0000;
				end
			endcase
		end
	end
  
	assign done = (state == 4'b0011);
	assign out_bytes = (done) ? out_bytes_reg : 0;

endmodule
