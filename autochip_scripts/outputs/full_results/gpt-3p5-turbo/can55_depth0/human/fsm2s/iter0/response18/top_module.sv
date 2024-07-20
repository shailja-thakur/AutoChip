module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
	end else begin
		case(state)
			2'b00: begin
				if (j) begin
					state <= 2'b01;
				end else begin
					state <= 2'b00;
				end
			end
			2'b01: begin
				if (k) begin
					state <= 2'b00;
				end else begin
					state <= 2'b01;
				end
			end
			default: begin
				state <= 2'b00;
			end
		endcase
	end
end

always @(state) begin
	case(state)
		2'b00: begin
			out <= 1'b0;
		end
		2'b01: begin
			out <= 1'b1;
		end
		default: begin
			out <= 1'b0;
		end
	endcase
end

endmodule
