module top_module (
  input [255:0] in,
  input [7:0] sel,
  output out
);

reg [7:0] sel_extended;
wire [255:0] selected_input;

assign sel_extended = sel; // Extend sel to match the width of in
assign selected_input = in >> (8 * sel_extended); // Shift the input vector based on the value of sel

assign out = |selected_input; // Perform bitwise OR operation on all bits of selected_input to get the output

endmodule
