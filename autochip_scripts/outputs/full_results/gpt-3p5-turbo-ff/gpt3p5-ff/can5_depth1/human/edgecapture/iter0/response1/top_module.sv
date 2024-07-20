module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);

// Intermediate registers to capture the input signal changes
reg [31:0] in_prev;

always @(posedge clk) begin
  if (reset) begin
    out <= 0;
  end else begin
    // Detect input signal changes from 1 to 0
    for (int i = 0; i < 32; i = i + 1) begin
      if (in[i] && !in_prev[i]) begin
        out[i] <= 1;
      end else begin
        out[i] <= 0;
      end
    end
    in_prev <= in;
  end
end

endmodule
