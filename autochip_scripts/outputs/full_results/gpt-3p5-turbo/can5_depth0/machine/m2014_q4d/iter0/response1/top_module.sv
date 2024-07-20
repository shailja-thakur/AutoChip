module top_module (
	input clk,
	input in,
	output logic out
);
  logic prev_out; // Previous output signal

  always_ff @(posedge clk) begin
    out <= in ^ prev_out; // Set output signal to XOR of input and previous output
    prev_out <= out; // Update previous output signal with current output
  end

  initial begin
    out <= 0; // Initialize output signal to 0
    prev_out <= 0; // Initialize previous output signal to 0
  end
endmodule
