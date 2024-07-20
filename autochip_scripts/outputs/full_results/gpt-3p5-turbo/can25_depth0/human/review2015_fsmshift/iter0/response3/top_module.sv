module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [3:0] count;
  reg enable;

  always @(posedge clk) begin
    if (reset) begin
      count <= 4'b0;
      enable <= 1'b1;
    end else if (count == 4'b11) begin
      count <= 4'b0;
      enable <= 1'b0;
    end else begin
      count <= count + 1'b1;
      enable <= 1'b1;
    end
  end

  assign shift_ena = enable;

endmodule
