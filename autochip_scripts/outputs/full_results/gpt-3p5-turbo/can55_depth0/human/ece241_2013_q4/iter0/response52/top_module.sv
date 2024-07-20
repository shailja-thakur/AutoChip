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
		state <= 2'b00;
		fr1 <= 1'b0;
		fr2 <= 1'b0;
		fr3 <= 1'b0;
		dfr <= 1'b0;
	end else begin
		case (state)
			2'b00: begin
				if (s[3]) begin
					state <= 2'b00;
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else if (s[2]) begin
					state <= 2'b01;
					fr1 <= 1'b1;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else if (s[1]) begin
					state <= 2'b10;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else begin
					state <= 2'b11;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b1;
					dfr <= 1'b0;
				end
			end
			
			2'b01: begin
				if (s[3]) begin
					state <= 2'b00;
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else if (s[2]) begin
					state <= 2'b01;
					fr1 <= 1'b1;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else if (s[1]) begin
					state <= 2'b10;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else begin
					state <= 2'b11;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b1;
					dfr <= 1'b0;
				end
			end
			
			2'b10: begin
				if (s[3]) begin
					state <= 2'b00;
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else if (s[2]) begin
					state <= 2'b01;
					fr1 <= 1'b1;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else if (s[1]) begin
					state <= 2'b10;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else begin
					state <= 2'b11;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b1;
					dfr <= 1'b0;
				end
			end
			
			2'b11: begin
				if (s[3]) begin
					state <= 2'b00;
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else if (s[2]) begin
					state <= 2'b01;
					fr1 <= 1'b1;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else if (s[1]) begin
					state <= 2'b10;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end else begin
					state <= 2'b11;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b1;
					dfr <= 1'b0;
				end
			end
		endcase
	end
end

endmodule
