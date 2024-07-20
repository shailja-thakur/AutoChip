module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  parameter OFF = 1'b0;
  parameter ON = 1'b1;

  reg state, next_state;
  reg out_reg;
  
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= OFF;
      out_reg <= OFF;
    end else begin
      state <= next_state;
      out_reg <= out;
    end
  end

  always @(state, j, k) begin
    next_state = state;
    case(state)
      OFF: begin
        if (j) begin
          next_state = ON;
          out = ON;
        end else begin
          next_state = OFF;
          out = OFF;
        end
      end
      ON: begin
        if (k) begin
          next_state = OFF;
          out = OFF;
        end else begin
          next_state = ON;
          out = ON;
        end
      end
    endcase
  end

endmodule
