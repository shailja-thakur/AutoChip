module top_module (
  input clk,
  input d,
  input r,
  output logic q
);

  // Creating a wire for negation of the reset signal
  wire r_n;
  assign r_n = ~r;
  
  // Creating a wire for the D flip flop output
  wire d_out;
  
  // Implementing the D flip flop
  always @(posedge clk or posedge r_n) begin
    if (r_n) begin
      q <= 0;
    end else begin
      q <= d;
    end
  end
  
endmodule
