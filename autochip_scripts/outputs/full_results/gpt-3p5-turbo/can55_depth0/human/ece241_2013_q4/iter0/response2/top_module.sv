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

always @ (posedge clk or posedge reset) begin
	if (reset) begin
		s_prev <= 3'b000;
		fr1 <= 1'b1;
		fr2 <= 1'b1;
		fr3 <= 1'b1;
		dfr <= 1'b0;
	end else begin
		s_prev <= s;
		
		case (s)
			3'b111: begin
				fr1 <= 1'b0;
				fr2 <= 1'b0;
				fr3 <= 1'b0;
				dfr <= 1'b0;
			end
			3'b110: begin
				fr1 <= 1'b1;
				fr2 <= 1'b0;
				fr3 <= 1'b0;
				dfr <= 1'b0;
			end
			3'b100: begin
				fr1 <= 1'b1;
				fr2 <= 1'b1;
				fr3 <= 1'b0;
				dfr <= 1'b0;
			end
			3'b000: begin
				fr1 <= 1'b1;
				fr2 <= 1'b1;
				fr3 <= 1'b1;
				dfr <= 1'b0;
			end
			default: begin
				fr1 <= 1'b0;
				fr2 <= 1'b0;
				fr3 <= 1'b0;
				dfr <= 1'b1;
			end
		endcase
	end
end

endmodule
