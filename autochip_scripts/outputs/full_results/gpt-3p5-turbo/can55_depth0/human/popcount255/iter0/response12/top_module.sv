module top_module (
  input [254:0] in,
  output reg [7:0] out
);

  // Declare a wire to store intermediate values
  wire [7:0] count;

  // Use a for loop to iterate through each bit of the input vector
  integer i;
  always @ (*) begin
    count = 0;
    for (i = 0; i < 255; i = i + 1) begin
      if (in[i] == 1'b1) begin
        count = count + 1;
      end
    end
    out = count;
  end
  
endmodule
