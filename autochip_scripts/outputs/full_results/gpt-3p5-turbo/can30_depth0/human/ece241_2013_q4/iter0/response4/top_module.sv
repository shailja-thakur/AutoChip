module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case (s)
			3'b100: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
			end
			3'b011: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b1;
			end
			3'b010: begin
				fr3 <= 1'b0;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
			end
			3'b001: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
			end
			default: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
			end
		endcase
	
		// Supplemental flow valve
		if (s[2] && ~s[1]) begin
			dfr <= 1'b1;
		end else begin
			dfr <= 1'b0;
		end
	end
end

endmodule
