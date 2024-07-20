module top_module (
    input [254:0] in,
    output reg [7:0] out
);

  reg [7:0] count; // Define a register to store the population count

  always @(*) begin
    count = 0; // Reset the count to 0
  
    // Use a for loop to iterate over each bit in the input vector
    for (int i = 0; i < 255; i = i + 1) begin
      if (in[i] == 1) begin
        count = count + 1; // Increment the count if the bit is 1
      end
    end
  
    out = count; // Assign the count value to the output
  end

endmodule
