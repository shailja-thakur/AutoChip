module top_module (
  input [254:0] in,
  output reg [7:0] out
);

  always @* begin
    // Initialize count variable
    integer count;
    count = 0;

    // Iterate through the input vector and count the number of '1's
    for (int i = 0; i < 255; i = i + 1) begin
      if (in[i] == 1'b1) begin
        count = count + 1;
      end
    end

    // Assign the count value to the output
    out = count;
  end

endmodule
