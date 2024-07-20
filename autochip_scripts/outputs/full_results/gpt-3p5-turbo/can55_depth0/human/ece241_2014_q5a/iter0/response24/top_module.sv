module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [3:0] state;
reg [3:0] next_state;
reg z;

parameter S0 = 4'b0000;
parameter S1 = 4'b0001;
parameter S2 = 4'b0010;
parameter S3 = 4'b0011;
parameter S4 = 4'b0100;
parameter S5 = 4'b0101;
parameter S6 = 4'b0110;
parameter S7 = 4'b0111;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= S0;
		z <= 0;
	end else begin
		state <= next_state;
		z <= (state == S2 || state == S3 || state == S5 || state == S6) ? ~x + 1 : z;
	end
end

always @(state) begin
	case(state)
		S0: next_state = (areset) ? S0 : S1;
		S1: next_state = (x) ? S2 : S1;
		S2: next_state = S3;
		S3: next_state = (x) ? S4 : S3;
		S4: next_state = (x) ? S4 : S5;
		S5: next_state = S6;
		S6: next_state = (x) ? S2 : S7;
		S7: next_state = (x) ? S2 : S1;
	endcase
end

endmodule
