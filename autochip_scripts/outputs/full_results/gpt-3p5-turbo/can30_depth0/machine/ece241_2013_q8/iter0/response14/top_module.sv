module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z,
	output reg [1:0] state
);

parameter S = 2'b00;
parameter S1 = 2'b01;
parameter S10 = 2'b10;

reg [1:0] state_next;

always @(posedge clk or negedge aresetn) begin
	if (!aresetn) begin
		state <= S;
	end else begin
		state <= state_next;
	end
end

always @(*) begin
	case ({x, state})
		2'b00_00: state_next = S;
		2'b01_00: state_next = S1;
		2'b00_01: state_next = S10;
		2'b01_01: state_next = S1;
		2'b00_10: state_next = S;
		2'b01_10: state_next = S1;
		default: state_next = S;
	endcase
end

always @(state) begin
	case (state)
		S: z = 1'b0;
		S1: z = 1'b0;
		S10: z = x;
	endcase
end

endmodule
