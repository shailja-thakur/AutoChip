module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg [1:0] next_state;
reg Z;

parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;
parameter s3 = 2'b11;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= s0;
		Z <= 0;
	end else begin
		state <= next_state;
		Z <= x;
	end
end

always @(*) begin
	case (state)
		s0: next_state = s1;
		s1: next_state = s2;
		s2: next_state = s3;
		s3: next_state = s0;
	endcase
end

assign z = ~Z + 1;

endmodule
