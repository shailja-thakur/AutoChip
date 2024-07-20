module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	reg [3:1] s_ff;  
	parameter ABOVES3 = 3'b111;
	parameter BETWEEN32 = 3'b110;
	parameter BETWEEN21 = 3'b100;
	parameter BELAWS1 = 3'b000;
	//Change sensitivity list for sensitivity to clk edge only.
	always @(posedge clk) begin
		if (reset) begin
			s_ff <= BELAWS1;
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end else begin
			s_ff <= s;
			case(s_ff)
				ABOVES3: begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b1;
				end
				BETWEEN32: begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b1;
				end
				BETWEEN21: begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
				end
				BELAWS1: begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
				end
				default: begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
				end
			endcase
		end
	end

endmodule
