module top_module (
  input clk,
  input resetn,
  input in,
  output out
);

  reg [3:0] sr;

  always @(posedge clk) begin
    if (resetn == 0) begin
      sr <= 4'b0000;  // Reset the register to all zeros
    end else begin
      sr <= {sr[2:0], in};  // Shift the register left by one bit and load the input into the least significant bit
    end
  end

  assign out = sr[3];  // Output the most significant bit of the register

endmodule
