module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [1:0] state;
reg [2:0] count;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

always @(negedge aresetn or posedge clk) begin
	if (~aresetn) begin
		state <= S0;
		count <= 3'b0;
	end else begin
		case (state)
			S0: begin
				if (x == 1'b1) begin
					state <= S1;
					count <= count + 1;
				end else begin
					state <= S0;
					count <= 3'b0;
				end
			end
			S1: begin
				if (x == 1'b0) begin
					state <= S2;
					count <= count + 1;
				end else begin
					state <= S0;
					count <= 3'b0;
				end
			end
			S2: begin
				if (x == 1'b1) begin
					state <= S1;
					count <= count + 1;
				end else begin
					state <= S0;
					count <= 3'b0;
				end
			end
		endcase
	end
end

always @(posedge clk) begin
	if (count >= 3) begin
		z <= 1'b1;
		count <= count + 1;
	end else begin
		z <= 1'b0;
	end
end

endmodule
