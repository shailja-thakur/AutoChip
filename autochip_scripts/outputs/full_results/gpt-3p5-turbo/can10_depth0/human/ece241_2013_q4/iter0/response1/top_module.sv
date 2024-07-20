module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:1] prev_s; // Previous sensor state

always @(posedge clk or posedge reset) begin
	if (reset) begin
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		prev_s <= s;

		case (s)
			3'b001:
				begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
			3'b010:
				begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
			3'b100:
				begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
			default:
				begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b1;
				end
		endcase
	end
end

endmodule
