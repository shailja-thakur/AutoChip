module top_module(
  input clk,
  input reset,
  output reg shift_ena);

  reg [2:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
    end else if (state == 3'b100) begin
      state <= 3'b101;
    end else if (state == 3'b101) begin
      state <= 3'b110;
    end else if (state == 3'b110) begin
      state <= 3'b111;
    end else if (state == 3'b111) begin
      state <= 3'b000;
    end else begin
      state <= 3'b011;
    end
  end

  assign shift_ena = (state == 3'b000) | (state == 3'b001) | (state == 3'b010) | (state == 3'b011);

endmodule
