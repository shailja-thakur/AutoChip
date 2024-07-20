module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [255:0] in_reg; // register to store the input
reg [7:0] sel_reg; // register to store the selector
wire [255:0] out_wire; // wire to connect the output of the multiplexer

// Register the input and selector
always @(posedge clk) begin
	in_reg <= in;
	sel_reg <= sel;
end

// Implement the multiplexer
assign out_wire = (sel_reg < 256) ? in_reg[sel_reg] : 1'bz;

// Output the result
assign out = out_wire;

endmodule
