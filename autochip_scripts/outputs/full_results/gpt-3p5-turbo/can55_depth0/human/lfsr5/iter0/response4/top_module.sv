module top_module (
  input clk,
  input reset,
  output reg [4:0] q
);

  reg [4:0] lfsr;

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      lfsr <= 5'b00001;
    end else begin
      lfsr <= {lfsr[3] ^ lfsr[5], lfsr[4:1]};
    end
  end

  assign q = lfsr;

endmodule
