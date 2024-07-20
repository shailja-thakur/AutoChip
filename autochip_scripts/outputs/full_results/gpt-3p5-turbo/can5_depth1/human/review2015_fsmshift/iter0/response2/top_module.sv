module top_module(
  input clk,
  input reset,
  output reg shift_ena);

  reg [3:0] count;

  always @(posedge clk) begin
    if (reset) begin
      count <= 4'b1111;
      shift_ena <= 1'b1;
    end else if (count != 4'b0000) begin
      count <= count - 1;
      shift_ena <= 1'b1;
    end else begin
      count <= 4'b0000;
      shift_ena <= 1'b0;
    end
  end

endmodule
