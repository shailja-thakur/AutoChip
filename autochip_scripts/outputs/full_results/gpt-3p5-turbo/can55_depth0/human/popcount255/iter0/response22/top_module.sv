module top_module (
  input [254:0] in,
  output reg [7:0] out
);

  always @(in)
  begin
    // Reset the output reg
    out <= 0;

    // Loop through each bit in the input vector
    for (int i = 0; i < 255; i = i + 1)
    begin
      // If the current bit is '1', increment the output reg
      if (in[i] == 1)
        out <= out + 1;
    end
  end

endmodule
