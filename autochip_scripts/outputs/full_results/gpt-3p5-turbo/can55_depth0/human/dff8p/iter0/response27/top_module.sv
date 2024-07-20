module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

  reg [7:0] dff [0:7];

  always @(negedge clk or posedge reset) begin
    if (reset) begin
      for (integer i = 0; i < 8; i = i + 1) begin
        dff[i] <= 8'b00110100;
      end
    end else begin
      for (integer i = 0; i < 8; i = i + 1) begin
        dff[i] <= d[i];
      end
    end
  end

  always @(posedge clk) begin
    q <= dff;
  end

endmodule
