module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

  reg state;
  reg x_reg;
  
  always @(posedge clk or negedge areset) begin
    if (!areset) begin
      state <= 0;
      x_reg <= 0;
      z <= 0;
    end else begin
      case(state)
        0: begin // IDLE State
          if (!areset)
            state <= 0;
          else if (!x)
            state <= 1;
        end
        1: begin // CONVERT State
          x_reg <= x;
          state <= 2;
        end
        2: begin // OUTPUT State
          if (x_reg)
            z <= ~z;
          state <= 0;
        end
      endcase
    end
  end
  
endmodule
