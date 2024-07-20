module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q
);

  reg [15:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count <= 16'b0000000000000000;
      ena <= 3'b000;
    end else begin
      if (count == 16'b1001100110011001) begin
        count <= 16'b0000000000000000;
        ena <= 3'b111;
      end else begin
        count <= count + 1;
        ena <= count[15:13];
      end
    end
    q = count;
  end
endmodule
