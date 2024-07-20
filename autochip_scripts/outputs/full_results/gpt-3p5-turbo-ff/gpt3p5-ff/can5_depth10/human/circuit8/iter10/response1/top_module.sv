module top_module (
	input wire clock,
	input wire a, 
	output wire p,
	output wire q
);

// Sequential circuit
reg [1:0] state;
reg [1:0] next_state;

always @(posedge clock) begin
	state <= next_state;
end

always @* begin
	next_state[0] = a;
	next_state[1] = (state[0] || state[1]);
end

assign p = state[0];
assign q = state[1];

endmodule
