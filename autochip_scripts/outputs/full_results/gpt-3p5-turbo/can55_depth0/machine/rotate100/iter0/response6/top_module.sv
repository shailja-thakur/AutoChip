module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

  reg [99:0] temp;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      if (ena == 2'b01) begin
        temp <= q << 1;
      end else if (ena == 2'b10) begin
        temp <= q >> 1;
      end
      q <= temp;
    end
  end

endmodule
