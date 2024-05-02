module top_module (
  input [99:0] in,
  output [99:0] out
);

  reg [99:0] temp;

  always @(posedge clk) begin
    for (int i = 0; i < 100; i++) begin
      temp[i] = in[99 - i];
    end
    out = temp;
  end

endmodule