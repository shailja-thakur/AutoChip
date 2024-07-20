module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg z;

// State encoding
parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else begin
		case(state)
			A: begin
				if (x)
					state <= B;
				else
					state <= A;
			end
			
			B: begin
				if (x)
					state <= B;
				else
					state <= A;
			end
		endcase
	end
end

// Output logic
always @(state, x) begin
	case(state)
		A: z = 0;
		B: z = 1;
	endcase
end

endmodule
