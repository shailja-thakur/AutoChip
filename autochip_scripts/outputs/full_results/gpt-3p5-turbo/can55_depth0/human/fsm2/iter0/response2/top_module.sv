module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

parameter OFF = 0;
parameter ON = 1;

reg [1:0] state;
reg out_next;

always @(posedge clk, posedge areset) begin
	if (areset) begin
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
			default: state <= OFF;
		endcase
	end
end

always @(state) begin
	case(state)
		OFF: out_next = 0;
		ON: out_next = 1;
		default: out_next = 0;
	endcase
end

assign out = out_next;

endmodule
