module top_module(
  input clk, // Clock input
  input reset, // Reset input
  output reg [3:0] q // 4-bit output register
);

  always @(posedge clk) begin
    if (reset || (q == 9)) begin // If reset is asserted or q is equal to 9
      q <= 0; // Reset q to 0
    end else begin
      q <= q + 1; // Increment q by 1
    end
  end
  
endmodule
