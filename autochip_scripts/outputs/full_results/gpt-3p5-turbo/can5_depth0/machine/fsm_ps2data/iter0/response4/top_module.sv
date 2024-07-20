module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

	reg [7:0] register;
	reg [23:0] out_bytes_reg;
	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			register <= 0;
			out_bytes_reg <= 0;
		end else begin
			case (state)
				0: begin // BYTE1
					if (in[2] == 1) begin
						register <= in;
						state <= 1;
					end else begin
						register <= register << 8;
						state <= 0;
					end
				end
				1: begin // BYTE2
					if (in[2] == 1) begin
						register <= in;
						state <= 2;
					end else begin
						register <= register << 8;
						state <= 0;
					end
				end
				2: begin // BYTE3
					if (in[2] == 1) begin
						register <= in;
						state <= 3;
					end else begin
						register <= register << 8;
						state <= 0;
					end
				end
				3: begin // DONE
					register <= register << 8;
					state <= 0;
				end
				default: state <= 0;
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == 3) begin
			out_bytes_reg <= register;
			done <= 1;
		end else begin
			done <= 0;
		end
	end
	
	assign out_bytes = out_bytes_reg;
	
endmodule
