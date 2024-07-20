module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg z;
	reg [2:0] state;

	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;

	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= S0;
			z <= 1'b0;
		end else begin
			case (state)
				S0: begin
					if (x == 1'b1) begin
						state <= S1;
						z <= 1'b1;
					end else begin
						state <= S0;
						z <= 1'b0;
					end
				end
			
				S1: begin
					if (x == 1'b1) begin
						state <= S2;
						z <= 1'b0;
					end else begin
						state <= S3;
						z <= 1'b1;
					end
				end
			
				S2: begin
					if (x == 1'b1) begin
						state <= S2;
						z <= 1'b0;
					end else begin
						state <= S3;
						z <= 1'b1;
					end
				end
			
				S3: begin
					if (x == 1'b1) begin
						state <= S2;
						z <= 1'b0;
					end else begin
						state <= S3;
						z <= 1'b1;
					end
				end
			
				S4: begin
					state <= S4;
					z <= 1'b1;
				end
			endcase
		end
	end
	
endmodule
