module top_module (
  input [255:0] in,
  input [7:0] sel,
  output  out
  );

  reg [7:0] sel_extended;
  reg [255:0] mux_input;

  always @(*) begin
    sel_extended = sel >> 3; // Right shift sel by 3 bits to convert it to a 8-bit value
    mux_input = in >> (sel*8); // Right shift in by (sel*8) bits
    out = mux_input[7:0]; // Assign the selected input to the output
  end

endmodule
