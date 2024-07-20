module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [2:0] state; // state variable to keep track of the water level

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0; // initialize state to 0 when reset is high
		fr3 <= 1;   // set fr3 output to 1 during reset
		fr2 <= 1;   // set fr2 output to 1 during reset
		fr1 <= 1;   // set fr1 output to 1 during reset
		dfr <= 1;   // set dfr output to 1 during reset
	end else begin
		case (state)
			0: begin // Water level above s[3]
				if (s[1] & s[2] & s[3])
					state <= 0; // stay in the same state
				else if (s[1] & s[2])
					state <= 1; // transition to state 1
				else if (s[1])
					state <= 2; // transition to state 2
				else
					state <= 3; // transition to state 3
				fr3 <= 0; // fr3 output is 0 when water level is above s[3]
				fr2 <= 0; // fr2 output is 0 when water level is above s[3]
				fr1 <= 0; // fr1 output is 0 when water level is above s[3]
				dfr <= 1; // dfr output is 1 when water level is above s[3]
			end
			1: begin // Water level between s[3] and s[2]
				if (s[1] & s[2])
					state <= 1; // stay in the same state
				else if (s[1])
					state <= 2; // transition to state 2
				else
					state <= 3; // transition to state 3
				fr3 <= 0; // fr3 output is 0 when water level is between s[3] and s[2]
				fr2 <= 0; // fr2 output is 0 when water level is between s[3] and s[2]
				fr1 <= 1; // fr1 output is 1 when water level is between s[3] and s[2]
				dfr <= 1; // dfr output is 1 when water level is between s[3] and s[2]				
			end
			2: begin // Water level between s[2] and s[1]
				if (s[1])
					state <= 2; // stay in the same state
				else
					state <= 3; // transition to state 3
				fr3 <= 0; // fr3 output is 0 when water level is between s[2] and s[1]
				fr2 <= 1; // fr2 output is 1 when water level is between s[2] and s[1]
				fr1 <= 1; // fr1 output is 1 when water level is between s[2] and s[1]
				dfr <= 1; // dfr output is 1 when water level is between s[2] and s[1]				
			end
			3: begin // Water level below s[1]
				state <= 3; // stay in the same state
				fr3 <= 1; // fr3 output is 1 when water level is below s[1]
				fr2 <= 1; // fr2 output is 1 when water level is below s[1]
				fr1 <= 1; // fr1 output is 1 when water level is below s[1]
				dfr <= 0; // dfr output is 0 when water level is below s[1]				
			end
		endcase
	end
end

endmodule
