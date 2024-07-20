module top_module(
  input clk,
  input reset,
  output reg shift_ena);

  reg [2:0] state;

  // State transition logic
  always @(posedge clk) begin
    if (reset == 1) begin
      state <= 3'b000;
    end else begin
      case(state)
        3'b000: state <= 3'b001;
        3'b001: state <= 3'b010;
        3'b010: state <= 3'b011;
        3'b011: state <= 3'b100;
        default: state <= 3'b100;
      endcase
    end
  end

  // shift_ena assignment logic
  always @(state) begin
    if (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) begin
      shift_ena <= 1;
    end else begin
      shift_ena <= 0;
    end
  end

endmodule
