module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  reg [2:0] state;
  reg f_reg, g_reg;
  reg [2:0] count;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= 3'b000;
      f_reg <= 1'b0;
      g_reg <= 1'b0;
      count <= 3'b000;
    end else begin
      case (state)
        3'b000: begin
          f_reg <= 1'b0;
          g_reg <= 1'b0;
          if (~resetn) begin
            state <= 3'b001;
          end
        end
        3'b001: begin
          f_reg <= 1'b1;
          g_reg <= 1'b0;
          state <= 3'b010;
        end
        3'b010: begin
          if (x == 1'b1) begin
            state <= 3'b011;
          end
        end
        3'b011: begin
          if (x == 1'b0) begin
            state <= 3'b100;
          end
        end
        3'b100: begin
          if (x == 1'b1) begin
            state <= 3'b101;
          end
        end
        3'b101: begin
          if (y == 1'b1) begin
            g_reg <= 1'b1;
            state <= 3'b110;
          end else begin
            if (count == 3'b010) begin
              g_reg <= 1'b0;
              state <= 3'b111;
            end
          end
        end
        3'b110: begin
          if (y == 1'b1) begin
            g_reg <= 1'b1;
          else
            g_reg <= 1'b0;
          end
          if (~resetn) begin
            state <= 3'b000;
          end
        end
        3'b111: begin
          g_reg <= 1'b0;
          if (~resetn) begin
            state <= 3'b000;
          end
        end
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (~resetn) begin
      count <= 3'b000;
    else begin
      count <= count + 1;
    end
  end

  assign f = f_reg;
  assign g = g_reg;

endmodule
