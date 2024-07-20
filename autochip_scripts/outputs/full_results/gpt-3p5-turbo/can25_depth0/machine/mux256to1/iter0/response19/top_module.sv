module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

  wire [7:0] sel_extended;
  assign sel_extended = {{248{1'b0}}, sel};

  wire [255:0] selected_bit;
  assign selected_bit = in & (1'b1 << sel_extended);

  bit_select selected_bit_1( .in(selected_bit), .out(out) );

endmodule
module bit_select (
	input [255:0] in,
	output  out
);

  wire [7:0] in_reduced;
  assign in_reduced = ^in;

  assign out = in_reduced;

endmodule
