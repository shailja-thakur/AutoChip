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

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// Reset the state machine
		state <= 0;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b0;
	end else begin
		case (state)
			0: begin
				if (s[3]) begin
					// Water level above s[3]
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= 0; // Stay in the same state
				end else if (s[2]) begin
					// Water level between s[3] and s[2]
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= 1; // Move to state 1
				end else if (s[1]) begin
					// Water level between s[2] and s[1]
					fr3 <= 1'b1;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= 2; // Move to state 2
				end else begin
					// Water level below s[1]
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b1;
					state <= 3; // Move to state 3
				end
			end
			1: begin
				if (s[3]) begin
					// Water level above s[3]
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= 0; // Move to state 0
				end else if (s[1]) begin
					// Water level between s[2] and s[1]
					fr3 <= 1'b1;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= 2; // Move to state 2
				end else begin
					// Water level below s[1]
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b1;
					state <= 3; // Move to state 3
				end
			end
			2: begin
				if (s[3]) begin
					// Water level above s[3]
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= 0; // Move to state 0
				end else if (!s[1]) begin
					// Water level below s[1]
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b1;
					state <= 3; // Move to state 3
				end
			end
			3: begin
				if (s[3]) begin
					// Water level above s[3]
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= 0; // Move to state 0
				end
			end
		endcase
	end
end

endmodule
