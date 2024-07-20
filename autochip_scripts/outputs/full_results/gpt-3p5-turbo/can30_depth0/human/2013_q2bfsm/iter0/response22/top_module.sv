module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
  
  reg [1:0] state;
  reg f_reg;
  reg g_reg;

  // Beginning state
  wire begin_state;
  assign begin_state = ~resetn;
  
  always @(posedge clk, negedge resetn) begin
    if(~resetn) begin
      state <= 2'b00; // State A
      f_reg <= 0;
      g_reg <= 0;
    end else begin
      case(state)
        2'b00: begin // State A
          if(begin_state) begin
            f_reg <= 0;
            g_reg <= 0;
          end else begin
            f_reg <= 1;
            state <= 2'b01; // State B
          end
        end

        2'b01: begin // State B
          f_reg <= 0;
          if(x == 1 && $fell(clk)) begin
            state <= 2'b10; // State C
          end
        end

        2'b10: begin // State C
          if(x == 0 && $fell(clk)) begin
            state <= 2'b11; // State D
          end
        end

        2'b11: begin // State D
          if(x == 1 && $fell(clk)) begin
            state <= 2'b01; // State B
            g_reg <= 1;
          end
        end
      endcase
    end
  end

  always @(posedge clk, negedge resetn) begin
    if (~resetn) begin
      g_reg <= 0;
    end else begin
      if (g_reg == 1) begin
        if (y == 1) begin
          g_reg <= 1;
        end else if (y == 0 && !$fell(clk)) begin
          g_reg <= 0;
        end
      end else begin
        g_reg <= 0;
      end
    end
  end

  assign f = f_reg;
  assign g = g_reg;

endmodule
