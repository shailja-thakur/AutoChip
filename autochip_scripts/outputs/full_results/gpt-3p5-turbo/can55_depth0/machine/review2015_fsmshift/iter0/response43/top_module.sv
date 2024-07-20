module top_module(
  input clk,
  input reset,
  output reg [2:0] state,
  output shift_ena
);

  // Internal wires and registers
  reg [2:0] next_state;
  
  // State transition logic
  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      case (state)
        3'b000: next_state = 3'b001;
        3'b001: next_state = 3'b010;
        3'b010: next_state = 3'b011;
        3'b011: next_state = 3'b100;
        default: next_state = 3'b100; // Done state
      endcase
      state <= next_state;
    end
  end
  
  // Shift enable logic
  assign shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);
  
endmodule
