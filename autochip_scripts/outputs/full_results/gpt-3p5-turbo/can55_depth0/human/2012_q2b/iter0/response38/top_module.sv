module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

// Declare the state flip-flops
reg y1_ff;
reg y3_ff;

// Assign the flip-flop inputs based on the current state
always@(y or w) begin
	case(y)
		6'b000001: begin
			y1_ff <= w;
			y3_ff <= y[3];
		end
		6'b000010: begin
			y1_ff <= w;
			y3_ff <= y[3];
		end
		6'b000100: begin
			y1_ff <= w;
			y3_ff <= y[3];
		end
		6'b001000: begin
			y1_ff <= w;
			y3_ff <= y[3];
		end
		6'b010000: begin
			y1_ff <= w;
			y3_ff <= y[3];
		end
		6'b100000: begin
			y1_ff <= w;
			y3_ff <= y[3];
		end
	endcase
end

// Assign the flip-flops to the output signals
assign Y1 = y1_ff;
assign Y3 = y3_ff;

endmodule
