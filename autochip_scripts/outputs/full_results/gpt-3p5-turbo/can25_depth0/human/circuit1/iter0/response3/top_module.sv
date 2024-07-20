module top_module (
  input a,
  input b,
  output q
);

  // Define internal wires
  wire q_temp;

  // Implement combinational circuit
  assign q_temp = a & ~b;

  // Synchronize final output
  always @(posedge clk) begin
    q <= q_temp;
  end

endmodule
