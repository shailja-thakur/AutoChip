module top_module (
  input [7:0] in,
  output [7:0] out
);
  
  // Variable declaration
  reg [7:0] reversed;

  // Reversing the bit ordering
  always @* begin
    for (int i = 0; i < 8; i = i + 1) begin
      reversed[i] = in[7-i];
    end
  end

  // Assigning the reversed value to the output
  assign out = reversed;

endmodule
