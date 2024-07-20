module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg out;
reg [1:0] state;

parameter OFF = 0;
parameter ON = 1;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= OFF;
	end else begin
		case(state)
			OFF: begin
				if (j) begin
					state <= ON;
				end else begin
					state <= OFF;
				end
			end
			ON: begin
				if (k) begin
					state <= OFF;
				end else begin
					state <= ON;
				end
			end
		endcase
	end
end

always @(state) begin
	case(state)
		OFF: begin
			out <= 0;
		end
		ON: begin
			out <= 1;
		end
	endcase
end

endmodule
