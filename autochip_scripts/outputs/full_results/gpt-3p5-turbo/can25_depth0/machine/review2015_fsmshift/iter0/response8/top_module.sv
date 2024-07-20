module top_module(
  input clk,
  input reset,
  output shift_ena,
  output reg [2:0] state);

  // State register
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000; // B0
    end else if (state == 3'b000) begin
      state <= 3'b001; // B1
    end else if (state == 3'b001) begin
      state <= 3'b010; // B2
    end else if (state == 3'b010) begin
      state <= 3'b011; // B3
    end else begin
      state <= 3'b100; // Done
    end
  end

  assign shift_ena = (state != 3'b100);

endmodule
