module top_module (
  input clk,
  input resetn,
  input in,
  output out
);

  reg [3:0] sr; // 4-bit register

  always @(posedge clk) begin
    if (resetn == 0) begin
      sr <= 4'b0000; // Reset register to all zeros
    end else begin
      sr <= {sr[2:0], in}; // Shift left by one bit and load input into least significant bit
    end
  end

  assign out = sr[3]; // Output is taken from the most significant bit of the register

endmodule
