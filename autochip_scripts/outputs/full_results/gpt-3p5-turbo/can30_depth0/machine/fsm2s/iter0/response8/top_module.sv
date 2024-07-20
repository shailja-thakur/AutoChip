module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  reg state, next_state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 1'b0;
    end else begin
      state <= next_state;
    end
  end

  always @(state, j, k) begin
    case (state)
      1'b0: begin
        if (j) begin
          next_state <= 1'b1;
        end else begin
          next_state <= 1'b0;
        end
      end
      
      1'b1: begin
        if (k) begin
          next_state <= 1'b0;
        end else begin
          next_state <= 1'b1;
        end
      end
    endcase
  end

  assign out = state;

endmodule
