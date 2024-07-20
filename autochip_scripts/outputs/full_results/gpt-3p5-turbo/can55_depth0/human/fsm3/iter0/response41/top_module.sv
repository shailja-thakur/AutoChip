module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire [1:0] next_state;
wire output;

// Define the state transition table
// state | next state in=0, next state in=1 | output
// A | A, B | 0
// B | C, B | 0
// C | A, D | 0
// D | C, B | 1
assign next_state[1] = (state == 2'b00 || state == 2'b01) ? 2'b00 : 2'b01;
assign next_state[0] = (state == 2'b01 || state == 2'b10) ? 2'b10 : 2'b01;
assign output = (state == 2'b11) ? 1'b1 : 1'b0;

// Define the sequential logic
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else
		state <= next_state;
end

// Define the output
assign out = output;

endmodule
