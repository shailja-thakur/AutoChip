module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg f_reg;
  reg g_reg;
  reg [1:0] state;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= 2'b0;
      f_reg <= 1'b0;
      g_reg <= 1'b0;
    end else begin
      case (state)
        2'b00: begin
          if (x) begin
            state <= 2'b01;
            f_reg <= 1'b1;
          end
        end
        2'b01: begin
          if (x) begin
            state <= 2'b10;
          end else begin
            state <= 2'b00;
            f_reg <= 1'b0;
          end
        end
        2'b10: begin
          if (x) begin
            state <= 2'b11;
            g_reg <= 1'b1;
          end else begin
            state <= 2'b00;
            f_reg <= 1'b0;
          end
        end
        2'b11: begin
          if (y) begin
            g_reg <= 1'b1;
          end else begin
            g_reg <= 1'b0;
          end
        end
      endcase
    end
  end

  assign f = f_reg;
  assign g = g_reg;

endmodule
