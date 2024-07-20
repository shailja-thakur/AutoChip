module top_module (
	input wire clk,
	input wire [7:0] in,
	input wire reset,
	output wire [23:0] out_bytes,
	output wire done
);

reg [23:0] out_reg;
reg [2:0] state;
reg [1:0] counter;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		out_reg <= 0;
		state <= 0;
		counter <= 0;
	end else begin
		case (state)
			0: begin  // BYTE1
				if (in[2] == 1'b1) begin
					state <= 1;  // BYTE2
				end else begin
					state <= 0;  // BYTE1
				end
			end
			
			1: begin  // BYTE2
				state <= 2;  // BYTE3
			end
			
			2: begin  // BYTE3
				state <= 3;  // DONE
			end
			
			3: begin  // DONE
				if (in[2] == 1'b0) begin
					state <= 0;  // BYTE1
				end else begin
					state <= 3;  // DONE
				end
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == 3) begin  // DONE
		out_bytes <= out_reg;
	end
	out_reg <= {out_reg[15:0], in};
end

assign done = (state == 3);

endmodule
