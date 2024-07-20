module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg z;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;

always @(posedge clk, posedge areset) begin
	if (areset) begin
		state <= S0;
		z <= 1'b0;
	end else begin
		case (state)
			S0: begin
				state <= S1;
				z <= 1'b0;
			end
			S1: begin
				state <= S2;
				z <= ~x;
			end
			S2: begin
				state <= S3;
				z <= ~z;
			end
			S3: begin
				state <= S0;
				z <= z;
			end
		endcase
	end
end

endmodule
