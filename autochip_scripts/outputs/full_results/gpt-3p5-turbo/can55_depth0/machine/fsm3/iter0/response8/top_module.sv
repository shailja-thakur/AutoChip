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
      state <= 2'b00; // state A
    end else begin
      state <= next_state;
    end
  end

  always @(state or in) begin
    case (state)
      2'b00: // state A
        begin
          if (in) begin
            next_state = 2'b01; // state B
          end else begin
            next_state = 2'b00; // state A
          end
        end
      2'b01: // state B
        begin
          if (in) begin
            next_state = 2'b01; // state B
          end else begin
            next_state = 2'b10; // state C
          end
        end
      2'b10: // state C
        begin
          if (in) begin
            next_state = 2'b11; // state D
          end else begin
            next_state = 2'b00; // state A
          end
        end
      2'b11: // state D
        begin
          if (in) begin
            next_state = 2'b01; // state B
          end else begin
            next_state = 2'b10; // state C
          end
        end
    endcase
  end

  always @(state) begin
    if (state == 2'b11) begin // state D
      out <= 1'b1;
    end else begin
      out <= 1'b0;
    end
  end

endmodule
