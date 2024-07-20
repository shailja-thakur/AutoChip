module top_module (
  input clk,
  input reset,
  output reg shift_ena
);

  reg [2:0] state;

  always @(posedge clk, posedge reset) begin
    if (reset)
      state <= 3'b000;
    else begin
      case (state)
        3'b000: if (/* detected bit pattern */) state <= 3'b001;
        3'b001: state <= 3'b010;
        3'b010: state <= 3'b011;
        3'b011: state <= 3'b100;
        3'b100: state <= 3'b000;
        default: state <= 3'b000;
      endcase
    end
  end

  always @(posedge clk) begin
    case (state)
      3'b000, 3'b001, 3'b010, 3'b011: shift_ena <= 1'b1;
      default: shift_ena <= 1'b0;
    endcase
  end

endmodule
