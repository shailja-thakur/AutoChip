module top_module (
  input clk,
  input in,
  input areset,
  output reg out
);

  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 0;
    end else begin
      state <= next_state;
    end
  end

  always @(state or in) begin
    case (state)
      2'b00: begin // State A
        if (in) begin
          next_state = 2'b01; // Next state B
        end else begin
          next_state = 2'b00; // Next state A
        end
      end

      2'b01: begin // State B
        if (in) begin
          next_state = 2'b01; // Next state B
        end else begin
          next_state = 2'b10; // Next state C
        end
      end

      2'b10: begin // State C
        if (in) begin
          next_state = 2'b11; // Next state D
        end else begin
          next_state = 2'b00; // Next state A
        end
      end

      2'b11: begin // State D
        if (in) begin
          next_state = 2'b01; // Next state B
        end else begin
          next_state = 2'b10; // Next state C
        end
      end
    endcase
  end

  always @(state) begin
    if (state == 2'b11) begin // State D
      out = 1;
    end else begin
      out = 0;
    end
  end

endmodule
