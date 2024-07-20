module top_module (
  input clk,
  input in,
  input reset,
  output out
);

reg [1:0] state, next_state;

always @(posedge clk) begin
  if (reset) begin
    state <= 2'b00; // initialize state to A
  end else begin
    state <= next_state;
  end
end

always @* begin
  case (state)
    2'b00: begin // state A
      if (in) begin
        next_state = 2'b01; // transition to state B
      end else begin
        next_state = 2'b00; // remain in state A
      end
    end
    2'b01: begin // state B
      if (in) begin
        next_state = 2'b01; // remain in state B
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

assign out = (state == 2'b11);

endmodule
