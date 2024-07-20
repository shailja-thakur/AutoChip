module top_module (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);

  always_comb begin
    min = a; // Assign initial minimum value to min register
    
    if (b < min) begin
      min = b; // Update min if b is less than current min
    end

    if (c < min) begin
      min = c; // Update min if c is less than current min
    end

    if (d < min) begin
      min = d; // Update min if d is less than current min
    end
  end

endmodule
