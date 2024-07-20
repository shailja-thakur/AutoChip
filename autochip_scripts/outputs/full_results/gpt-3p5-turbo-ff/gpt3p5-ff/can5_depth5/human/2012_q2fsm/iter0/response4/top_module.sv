module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// State parameters
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

reg [1:0] state;
reg z;

always @(posedge clk, posedge reset)
begin
	if (reset)
		state <= A;
	else
		case (state)
			A: begin
				if (w)
					state <= B;
				else
					state <= A;
			end
			
			B: begin
				if (w)
					state <= C;
				else
					state <= D;
			end
			
			C: begin
				if (w)
					state <= E;
				else
					state <= D;
			end
			
			D: begin
				if (w)
					state <= F;
				else
					state <= A;
			end
			
			E: begin
				if (w)
					state <= E;
				else
					state <= D;
			end
			
			F: begin
				if (w)
					state <= C;
				else
					state <= D;
			end
		endcase
end

always @*
begin
	case (state)
		E: z = 1'b1;
		default: z = 1'b0;
	endcase
end

endmodule
