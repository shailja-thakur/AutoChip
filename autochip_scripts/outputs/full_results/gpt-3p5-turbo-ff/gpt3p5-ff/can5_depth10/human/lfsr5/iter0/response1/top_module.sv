module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] lfsr;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr <= 5'b1;
    end else begin
      lfsr <= {lfsr[2]^lfsr[4], lfsr[3:0]};
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      q <= 5'b0;
    end else begin
      q <= lfsr;
    end
  end

endmodule
