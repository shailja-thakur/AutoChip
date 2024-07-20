module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

  always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
      q <= 4'b0000;  // Reset the output register to 0 when asynchronous reset is active
    end else if (load == 1) begin
      q <= data;  // Load the data input into the output register when load signal is active
    end else if (ena == 1) begin
      q <= {q[2:0], q[3]};  // Shift the output register left by 1 bit when enable signal is active
    end
  end

endmodule
