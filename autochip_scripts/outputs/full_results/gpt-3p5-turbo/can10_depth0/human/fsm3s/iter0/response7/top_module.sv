module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out_reg;
wire [3:0] next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
	end else begin
		state <= next_state;
	end
end

// Output logic
always @(state) begin
	case (state)
		0: out_reg <= 1'b0;
		1: out_reg <= 1'b0;
		2: out_reg <= 1'b0;
		3: out_reg <= 1'b1;
		endcase
end

// Next state logic
always @(state, in) begin
	case (state)
		0: next_state <= (in) ? 2'b01 : 2'b00;
		1: next_state <= (in) ? 2'b01 : 2'b10;
		2: next_state <= (in) ? 2'b00 : 2'b11;
		3: next_state <= (in) ? 2'b10 : 2'b10;
	endcase
end

assign out = out_reg;

endmodule
