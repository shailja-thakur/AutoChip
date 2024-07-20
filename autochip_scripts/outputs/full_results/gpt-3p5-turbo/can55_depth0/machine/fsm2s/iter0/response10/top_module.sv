module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);

  reg state, next_state;

  always @(posedge clk) begin
    if (reset == 1) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  always @* begin
    case (state)
      A: begin
        if (j == 1) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      B: begin
        if (k == 1) begin
          next_state = A;
        end else begin
          next_state = B;
        end
      end
    endcase
  end

  always @* begin
    if (state == B) begin
      out = 1;
    end else begin
      out = 0;
    end
  end

endmodule
