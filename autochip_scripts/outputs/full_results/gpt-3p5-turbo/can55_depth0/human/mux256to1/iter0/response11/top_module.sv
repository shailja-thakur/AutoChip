module top_module (
  input [255:0] in,
  input [7:0] sel,
  output out
);

wire [255:0] selected_input;
wire [7:0] sel_reduced;

assign sel_reduced = {8{sel[7]}};
assign selected_input = in & sel_reduced;

assign out = selected_input[0];

endmodule
