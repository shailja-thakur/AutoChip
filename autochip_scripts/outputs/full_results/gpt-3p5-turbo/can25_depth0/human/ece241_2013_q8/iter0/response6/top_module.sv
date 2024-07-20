module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;

// State definitions
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;

always @(posedge clk or negedge aresetn)
begin
	if (~aresetn)
		state <= S0;
	else
	begin
		case (state)
			S0: if (x)
					state <= S1;
				else
					state <= S0;
			S1: if (x)
					state <= S1;
				else
					state <= S2;
			S2: if (x)
					state <= S3;
				else
					state <= S0;
			default: state <= S0;
		endcase
	end
end

always @(state, x)
begin
	case (state)
		S0: z = 0;
		S1: z = 0;
		S2: z = x;
		default: z = 0;
	endcase
end

endmodule
