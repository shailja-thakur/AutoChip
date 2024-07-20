module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg state;
  reg next_state;

  always @(posedge clk, posedge areset) begin
    if (areset) begin
      state <= 1'b0;
    end else begin
      state <= next_state;
    end
  end

  always @(state, in) begin
    case (state)
      1'b0:
        if (in) begin
          next_state <= 1'b0;
        end else begin
          next_state <= 1'b1;
        end
      1'b1:
        if (in) begin
          next_state <= 1'b1;
        end else begin
          next_state <= 1'b0;
        end
      default:
        next_state <= 1'b0;
    endcase
  end

  assign out = (state == 1'b1) ? 1'b1 : 1'b0;

endmodule
