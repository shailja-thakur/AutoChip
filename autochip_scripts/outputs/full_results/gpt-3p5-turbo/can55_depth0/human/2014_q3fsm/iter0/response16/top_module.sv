module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

reg [1:0] state;

always @(posedge clk) begin
  if (reset)
    state <= 2'b00;
  else begin
    case (state)
      2'b00:
        if (s)
          state <= 2'b01;
        else
          state <= 2'b00;
      2'b01:
        state <= 2'b10;
      2'b10:
        if (w == 2'b11)
          state <= 2'b11;
        else
          state <= 2'b00;
      2'b11:
        if (w == 2'b11)
          state <= 2'b11;
        else if (w == 2'b01 || w == 2'b10)
          state <= 2'b00;
        else
          state <= 2'b10;
    endcase
  end
end

always @(posedge clk) begin
  if (reset)
    z <= 1'b0;
  else begin
    case (state)
      2'b11:
        z <= 1'b1;
      default:
        z <= 1'b0;
    endcase
  end
end

endmodule
