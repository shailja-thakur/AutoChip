module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;
	
	reg [2:0] y, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			y <= S0;
		end else begin
			y <= next_state;
		end
	end
	
	always @(y or x) begin
		case (y)
			S0: begin
				if (x) begin
					next_state = S1;
					z = 0;
				end else begin
					next_state = S0;
					z = 0;
				end
			end
			S1: begin
				if (x) begin
					next_state = S4;
					z = 0;
				end else begin
					next_state = S1;
					z = 0;
				end
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 0;
				end else begin
					next_state = S2;
					z = 0;
				end
			end
			S3: begin
				if (x) begin
					next_state = S2;
					z = 1;
				end else begin
					next_state = S1;
					z = 0;
				end
			end
			S4: begin
				if (x) begin
					next_state = S4;
					z = 1;
				end else begin
					next_state = S3;
					z = 1;
				end
			end
		endcase
	end
endmodule
