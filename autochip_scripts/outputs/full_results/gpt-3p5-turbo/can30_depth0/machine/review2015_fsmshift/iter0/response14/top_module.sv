module top_module(
  input clk,
  input reset,
  output reg [2:0] state,
  output reg shift_ena);

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000; // B0
    end else begin
      case (state)
        3'b000: state <= 3'b001; // B1
        3'b001: state <= 3'b010; // B2
        3'b010: state <= 3'b011; // B3
        3'b011: state <= 3'b100; // Done
        default: state <= 3'b100; // Done
      endcase
    end

    if (reset || state[2:0] != 3'b100) begin
      shift_ena <= 1;
    end else begin
      shift_ena <= 0;
    end
  end

endmodule
