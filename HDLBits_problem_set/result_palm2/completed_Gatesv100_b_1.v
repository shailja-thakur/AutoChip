module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different );

  reg [99:0] in_reg;
  reg [98:0] out_both_reg;
  reg [99:1] out_any_reg;
  reg [99:0] out_different_reg;

  always @(posedge clk) begin
    in_reg <= in;
  end

  always @(posedge clk) begin
    out_both_reg <= in_reg[99] & in_reg[98];
    for (int i = 98; i >= 1; i--) begin
      out_both_reg[i - 1] <= in_reg[i] & in_reg[i - 1];
    end
  end

  always @(posedge clk) begin
    out_any_reg <= in_reg[99] | in_reg[98];
    for (int i = 98; i >= 1; i--) begin
      out_any_reg[i - 1] <= in_reg[i] | in_reg[i - 1];
    end
  end

  always @(posedge clk) begin
    out_different_reg <= in_reg[99] ^ in_reg[98];
    for (int i = 98; i >= 1; i--) begin
      out_different_reg[i - 1] <= in_reg[i] ^ in_reg[i - 1];
    end
  end

  assign out_both = out_both_reg;
  assign out_any = out_any_reg;
  assign out_different = out_different_reg;

endmodule