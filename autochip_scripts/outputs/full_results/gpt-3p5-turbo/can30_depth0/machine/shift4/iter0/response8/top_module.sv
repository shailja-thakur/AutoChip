module top_module (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

always @(posedge clk or posedge areset) begin
  if (areset == 1'b1) // Check if asynchronous reset is active
    q <= 4'b0; // Output register is set to 0

  else if (load == 1'b1) // Check if load signal is active
    q <= data; // Load data input into the output register

  else if (ena == 1'b1) // Check if enable signal is active
    q <= {q[2:0], 1'b0}; // Shift output register left by 1 bit

  // None of the signals are active, output register remains unchanged

end

endmodule
