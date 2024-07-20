module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 4'b0000;
	end else begin
		case (state)
			4'b0000: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (s[3]) begin
					state <= 4'b0001;
				end
			end
			4'b0001: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (!s[3] && s[2]) begin
					state <= 4'b0010;
				end
			end
			4'b0010: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b0;
				dfr <= 1'b0;
				if (!s[2] && s[1]) begin
					state <= 4'b0011;
				end
			end
			4'b0011: begin
				fr3 <= 1'b1;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
				dfr <= 1'b0;
				if (!s[1]) begin
					state <= 4'b0100;
				end
			end
			4'b0100: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
				dfr <= 1'b0;
				state <= 4'b0000;
			end
		endcase
	end
end

endmodule
