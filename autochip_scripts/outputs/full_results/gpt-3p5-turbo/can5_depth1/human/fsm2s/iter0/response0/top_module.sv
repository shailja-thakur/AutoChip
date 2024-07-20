module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
wire out;

// State registers
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0;
	end else begin
		case(state)
			0: if (j) state <= 2'b1; else state <= 2'b0;
			1: if (k) state <= 2'b0; else state <= 2'b1;
		endcase
	end
end

// Output logic
always @(*) begin
	case(state)
		0: out = 1'b0;
		1: out = 1'b1;
	endcase
end

endmodule
