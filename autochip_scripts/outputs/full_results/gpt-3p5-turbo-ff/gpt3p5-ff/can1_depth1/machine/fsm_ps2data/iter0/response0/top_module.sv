module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [23:0] out_reg;
reg [3:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		out_reg <= 0;
		state <= 4'b0000;
	end else begin
		state <= next_state;
		case (state)
			4'b0000: begin  // BYTE1
				if (in[2] == 1) begin
					next_state = 4'b0010;  // BYTE2
				end else begin
					next_state = 4'b0000;  // Stay in BYTE1
				end
			end
			4'b0010: begin  // BYTE2
				next_state = 4'b0100;  // BYTE3
			end
			4'b0100: begin  // BYTE3
				next_state = 4'b1000;  // DONE
			end
			4'b1000: begin  // DONE
				if (in[2] == 0) begin
					next_state = 4'b0000;  // BYTE1
				end else begin
					next_state = 4'b1000;  // Stay in DONE
				end
			end
		endcase
	end
end

always @(posedge clk) begin
	if (done) begin
		out_bytes <= out_reg;
	end
	out_reg <= {out_reg[15:0], in};
end

assign done = (state == 4'b1000);

endmodule
