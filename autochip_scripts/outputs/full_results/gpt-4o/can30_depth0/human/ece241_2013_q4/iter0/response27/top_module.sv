module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	reg [3:1] prev_s;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset all outputs
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 1;
			prev_s <= 3'b000;
		end else begin
			// Default outputs to zero (all flow rates closed, dfr inactive)
			fr3 <= 0;
			fr2 <= 0;
			fr1 <= 0;
			dfr <= 0;
			
			if (s[3]) begin
				// Above s[3], no flow
				fr1 <= 0;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;
			end else if (s[2]) begin
				// Between s[3] and s[2], nominal flow rate fr1
				fr1 <= 1;
				fr2 <= 0;
				fr3 <= 0;
				// If previously lower (sensors state increased), open supplemental flow valve
				if (prev_s < s) 
					dfr <= 1;
			end else if (s[1]) begin
				// Between s[2] and s[1], nominal flow rates fr1 and fr2
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 0;
				// If previously lower (sensors state increased), open supplemental flow valve
				if (prev_s < s)
					dfr <= 1;
			end else begin
				// Below s[1], maximum flow rate (all valves open)
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 1;
				dfr <= 1;
			end
			
			// Update the previous sensor state
			prev_s <= s;
		end
	end

endmodule
