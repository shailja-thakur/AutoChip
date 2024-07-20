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
	reg [3:1] prev_s;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			prev_s <= 3'b000;
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end else begin
			prev_s <= s;
			
			case (state)
				3'b000: begin
					if (s[3]) begin
						state <= 3'b000;
						fr3 <= 1'b0;
						fr2 <= 1'b0;
						fr1 <= 1'b0;
						dfr <= 1'b0;
					end else if (s[2]) begin
						state <= 3'b001;
						fr3 <= 1'b0;
						fr2 <= 1'b0;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end else if (s[1]) begin
						state <= 3'b010;
						fr3 <= 1'b0;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end else begin
						state <= 3'b100;
						fr3 <= 1'b1;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end
				end
				3'b001: begin
					if (s[3]) begin
						state <= 3'b000;
						fr3 <= 1'b0;
						fr2 <= 1'b0;
						fr1 <= 1'b0;
						dfr <= 1'b0;
					end else if (s[2]) begin
						state <= 3'b001;
						fr3 <= 1'b0;
						fr2 <= 1'b0;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end else if (s[1]) begin
						state <= 3'b010;
						fr3 <= 1'b0;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end else begin
						state <= 3'b100;
						fr3 <= 1'b1;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end
				end
				3'b010: begin
					if (s[3]) begin
						state <= 3'b000;
						fr3 <= 1'b0;
						fr2 <= 1'b0;
						fr1 <= 1'b0;
						dfr <= 1'b0;
					end else if (s[2]) begin
						state <= 3'b001;
						fr3 <= 1'b0;
						fr2 <= 1'b0;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end else if (s[1]) begin
						state <= 3'b010;
						fr3 <= 1'b0;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end else begin
						state <= 3'b100;
						fr3 <= 1'b1;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end
				end
				3'b100: begin
					if (s[3]) begin
						state <= 3'b000;
						fr3 <= 1'b0;
						fr2 <= 1'b0;
						fr1 <= 1'b0;
						dfr <= 1'b0;
					end else if (s[2]) begin
						state <= 3'b001;
						fr3 <= 1'b0;
						fr2 <= 1'b0;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end else if (s[1]) begin
						state <= 3'b010;
						fr3 <= 1'b0;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end else begin
						state <= 3'b100;
						fr3 <= 1'b1;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end
				end
			endcase
		end
	end
	
endmodule
