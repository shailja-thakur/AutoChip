module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

// Register for storing the value
reg [n-1:0] register;

// Mux for selecting the input value
wire [1:0] select;
assign select = (E & L) ? 2'b11 : (E & !L) ? 2'b10 : 2'b01;

// Flip-flop for storing the value
always @(posedge clk) begin
	if (R) begin
		register <= 0;
		Q <= 0;
	end
	else if (select == 2'b11)
		Q <= w;
	else
		Q <= register;
end

// Mux for selecting the output value
assign register = (select == 2'b10) ? w : Q;

endmodule
