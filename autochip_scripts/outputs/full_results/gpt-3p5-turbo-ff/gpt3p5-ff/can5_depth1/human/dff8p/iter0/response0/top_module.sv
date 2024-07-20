module top_module(
  input wire clk,
  input wire [7:0] d,
  input wire reset,
  output reg [7:0] q
);

  always @(posedge clk or negedge reset) begin
    if (reset == 0) begin
      q <= 8'b00110100;
    end else if (clk'event and clk == 0) begin
      q <= d;
    end
  end

endmodule
