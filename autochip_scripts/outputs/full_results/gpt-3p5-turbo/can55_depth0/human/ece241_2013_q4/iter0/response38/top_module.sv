module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:1] s_prev;
reg [3:1] s_change;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		s_prev <= 0;
		s_change <= 0;
		fr3 <= 1;
		fr2 <= 1;
		fr1 <= 1;
		dfr <= 0;
	end else begin
		s_prev <= s;
		s_change <= s_prev ^ s;
		
		// Above s[3]
		if (s[3]) begin
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 0;
		end
		
		// Between s[3] and s[2]
		if (s[2] && !s[3]) begin
			fr3 <= 0;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 0;
		end
		
		// Between s[2] and s[1]
		if (s[1] && !s[2] && !s[3]) begin
			fr3 <= 0;
			fr2 <= 0;
			fr1 <= 1;
			dfr <= 0;
		end
		
		// Below s[1]
		if (!s[1] && !s[2] && !s[3]) begin
			fr3 <= 0;
			fr2 <= 0;
			fr1 <= 0;
			dfr <= 1;
		end
		
		// Handle s_change
		if (s_change[2]) begin
			fr2 <= fr2 + 1;
		end
		
		if (s_change[1]) begin
			fr1 <= fr1 + 1;
		end
	end
end

endmodule
