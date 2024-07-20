module top_module (
  input clk,
  input in,
  output logic out
);

  // Flip-flop register for storing the previous output
  logic prev_out;

  always_ff @(posedge clk) begin
    // Toggle the output signal
    out <= in ^ prev_out;
    // Update the previous output value
    prev_out <= out;
  end

endmodule
