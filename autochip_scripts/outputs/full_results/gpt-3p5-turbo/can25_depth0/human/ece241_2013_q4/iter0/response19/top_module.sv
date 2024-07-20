module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [1:0] state;
reg [1:0] nextState;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= S0;
	else
		state <= nextState;
end

always @(state or s) begin
	case(state)
		S0: begin
			if (s[3])
				nextState = S0;
			else if (s[2])
				nextState = S1;
			else if (s[1])
				nextState = S2;
			else
				nextState = S3;
		end
		
		S1: begin
			if (s[3])
				nextState = S0;
			else if (s[2])
				nextState = S1;
			else if (s[1])
				nextState = S2;
			else
				nextState = S3;
		end
		
		S2: begin
			if (s[3])
				nextState = S0;
			else if (s[2])
				nextState = S1;
			else if (s[1])
				nextState = S2;
			else
				nextState = S3;
		end
		
		S3: begin
			if (s[3])
				nextState = S0;
			else if (s[2])
				nextState = S1;
			else if (s[1])
				nextState = S2;
			else
				nextState = S3;
		end
	endcase
end

always @(state) begin
	case(state)
		S0: begin
			fr1 <= 0;
			fr2 <= 0;
			fr3 <= 0;
			dfr <= 0;
		end
		
		S1: begin
			fr1 <= 1;
			fr2 <= 0;
			fr3 <= 0;
			dfr <= 0;
		end
		
		S2: begin
			fr1 <= 1;
			fr2 <= 1;
			fr3 <= 0;
			dfr <= 0;
		end
		
		S3: begin
			fr1 <= 1;
			fr2 <= 1;
			fr3 <= 1;
			dfr <= 1;
		end
	endcase
end

endmodule
