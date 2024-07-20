module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

  reg q_next;
  reg state_next;

  always @(posedge clk) begin
    q <= q_next;
    state <= state_next;
  end

  always @(clk, a, b) begin
    case ({state, a, b})
      3'b000: begin // state = 0, a = 0, b = 0
        q_next = 1'b0;
        state_next = 3'b000;
      end

      3'b001: begin // state = 0, a = 0, b = 1
        q_next = 1'b1;
        state_next = 3'b001;
      end

      3'b010: begin // state = 0, a = 1, b = 0
        q_next = 1'b1;
        state_next = 3'b001;
      end

      3'b011: begin // state = 0, a = 1, b = 1
        q_next = 1'b0;
        state_next = 3'b010;
      end

      3'b100: begin // state = 1, a = 0, b = 0
        q_next = 1'b1;
        state_next = 3'b010;
      end

      3'b101: begin // state = 1, a = 0, b = 1
        q_next = 1'b1;
        state_next = 3'b011;
      end

      3'b110: begin // state = 1, a = 1, b = 0
        q_next = 1'b0;
        state_next = 3'b100;
      end

      3'b111: begin // state = 1, a = 1, b = 1
        q_next = 1'b1;
        state_next = 3'b101;
      end

      default: begin
        q_next = 1'b0;
        state_next = 3'b000;
      end
    endcase
  end

endmodule
