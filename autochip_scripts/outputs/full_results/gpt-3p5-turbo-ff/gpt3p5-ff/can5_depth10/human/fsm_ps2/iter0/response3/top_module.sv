module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
	
	reg [2:0] state;
	reg done;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b0;
			done <= 0;
		end else begin
			case(state)
				3'b000: begin
					if (in[3] == 1) begin
						state <= 3'b001;
					end else begin
						state <= 3'b000;
					end
				end
				3'b001: begin
					state <= 3'b010;
				end
				3'b010: begin
					if (in[3] == 1) begin
						state <= 3'b011;
					end else begin
						state <= 3'b000;
					end
				end
				3'b011: begin
					state <= 3'b100;
				end
				3'b100: begin
					if (in[3] == 1) begin
						state <= 3'b101;
					end else begin
						state <= 3'b000;
					end
				end
				3'b101: begin
					state <= 3'b110;
				end
				3'b110: begin
					state <= 3'b111;
				end
				3'b111: begin
					done <= 1;
					state <= 3'b000;
				end
				default: begin
					state <= 3'b000;
				end
			endcase
		end
	end

endmodule
