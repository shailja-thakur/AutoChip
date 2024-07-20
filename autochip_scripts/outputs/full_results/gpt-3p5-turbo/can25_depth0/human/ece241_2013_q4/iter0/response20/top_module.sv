module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:1] s_reg;
reg [3:1] s_prev;

always @(posedge clk) begin
	if (reset) begin
		s_reg <= 3'b000;
		s_prev <= 3'b000;
		fr3 <= 0;
		fr2 <= 0;
		fr1 <= 0;
		dfr <= 1;
	end else begin
		s_prev <= s_reg;
		s_reg <= s;
		
		case (s_reg)
			3'b100: begin
				fr3 <= 1;
				fr2 <= 0;
				fr1 <= 0;
				dfr <= 0;
			end
			
			3'b110: begin
				fr3 <= 0;
				fr2 <= 1;
				fr1 <= 0;
				if (s_prev < s_reg) begin
					dfr <= 1;
				end else begin
					dfr <= 0;
				end
			end
			
			3'b111: begin
				fr3 <= 0;
				fr2 <= 1;
				fr1 <= 1;
				if (s_prev < s_reg) begin
					dfr <= 1;
				end else begin
					dfr <= 0;
				end
			end
			
			3'b000: begin
				fr3 <= 1;
				fr2 <= 1;
				fr1 <= 1;
				dfr <= 1;
			end
		endcase
	end
end

endmodule
