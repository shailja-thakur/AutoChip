module top_module(
  input clk,
  input reset,
  output shift_ena,
  output reg [2:0] state
  );

  reg [2:0] next_state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      state <= next_state;
    end
  end

  always @(state) begin
    case (state)
      3'b000: begin // B0
        next_state = 3'b001;
        shift_ena = 1;
      end

      3'b001: begin // B1
        next_state = 3'b010;
        shift_ena = 1;
      end

      3'b010: begin // B2
        next_state = 3'b011;
        shift_ena = 1;
      end

      3'b011: begin // B3
        next_state = 3'b100;
        shift_ena = 1;
      end

      default: begin // Done
        next_state = 3'b100;
        shift_ena = 0;
      end
    endcase
  end

endmodule
