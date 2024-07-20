module top_module (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);

  always_comb begin
    case (state)
      2'b00: begin // state A
        if (in) begin
          next_state = 2'b01; // transition to state B
        end else begin
          next_state = 2'b00; // stay in state A
        end
      end
      2'b01: begin // state B
        if (in) begin
          next_state = 2'b01; // stay in state B
        end else begin
          next_state = 2'b10; // transition to state C
        end
      end
      2'b10: begin // state C
        if (in) begin
          next_state = 2'b11; // transition to state D
        end else begin
          next_state = 2'b00; // transition to state A
        end
      end
      2'b11: begin // state D
        if (in) begin
          next_state = 2'b01; // transition to state B
        end else begin
          next_state = 2'b10; // transition to state C
        end
      end
    endcase
  end

  assign out = (state == 2'b11); // set 'out' to high when in state D

endmodule
