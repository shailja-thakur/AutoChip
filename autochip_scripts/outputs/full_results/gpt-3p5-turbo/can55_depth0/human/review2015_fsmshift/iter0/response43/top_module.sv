module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [3:0] shift_count;
  reg shift_enable;

  always @(posedge clk or posedge reset) begin
    if (reset)
      shift_count <= 4'b1111;
    else if (shift_enable)
      shift_count <= shift_count - 1;
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      shift_ena <= 1'b1;
    else if (shift_count == 0)
      shift_ena <= 1'b0;
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      shift_enable <= 1'b1;
    else if (shift_count == 0)
      shift_enable <= 1'b0;
  end

endmodule
