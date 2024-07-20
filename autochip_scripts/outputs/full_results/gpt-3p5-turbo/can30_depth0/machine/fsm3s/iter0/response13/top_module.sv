module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state;
reg out_reg;

// State register
always @(posedge clk or posedge reset)
begin
	if (reset)
		state <= A;
	else
		case(state)
			A: begin
				if (in)
					state <= B;
				else
					state <= A;
			end
			
			B: begin
				if (in)
					state <= B;
				else
					state <= C;
			end
			
			C: begin
				if (in)
					state <= D;
				else
					state <= A;
			end
			
			D: begin
				if (in)
					state <= B;
				else
					state <= C;
			end
		endcase
end

// Output assignment
always @(state)
begin
	if (state == D)
		out_reg = 1;
	else
		out_reg = 0;
end

assign out = out_reg;

endmodule
