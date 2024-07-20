module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		dfr <= 0;
		fr1 <= 0;
		fr2 <= 0;
		fr3 <= 1;
	end else begin
		case (state)
			3'b000: begin
				if (s[3]) begin
					state <= 3'b000;
					dfr <= 0;
					fr1 <= 0;
					fr2 <= 0;
					fr3 <= 0;
				end else if (s[2]) begin
					state <= 3'b001;
					dfr <= 0;
					fr1 <= 1;
					fr2 <= 0;
					fr3 <= 0;
				end else if (s[1]) begin
					state <= 3'b010;
					dfr <= 0;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 0;
				end else begin
					state <= 3'b100;
					dfr <= 1;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 1;
				end
			end
			3'b001: begin
				if (s[3]) begin
					state <= 3'b000;
					dfr <= 0;
					fr1 <= 0;
					fr2 <= 0;
					fr3 <= 0;
				end else if (s[2]) begin
					state <= 3'b001;
					dfr <= 0;
					fr1 <= 1;
					fr2 <= 0;
					fr3 <= 0;
				end else if (s[1]) begin
					state <= 3'b010;
					dfr <= 0;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 0;
				end else begin
					state <= 3'b100;
					dfr <= 1;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 1;
				end
			end
			3'b010: begin
				if (s[2]) begin
					state <= 3'b001;
					dfr <= 0;
					fr1 <= 1;
					fr2 <= 0;
					fr3 <= 0;
				end else if (s[1]) begin
					state <= 3'b010;
					dfr <= 0;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 0;
				end else begin
					state <= 3'b100;
					dfr <= 1;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 1;
				end
			end
			3'b100: begin
				if (!s[1] && !s[2] && !s[3]) begin
					state <= 3'b000;
					dfr <= 0;
					fr1 <= 0;
					fr2 <= 0;
					fr3 <= 0;
				end else begin
					state <= 3'b100;
					dfr <= 1;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 1;
				end
			end
		endcase
	end
end

endmodule
