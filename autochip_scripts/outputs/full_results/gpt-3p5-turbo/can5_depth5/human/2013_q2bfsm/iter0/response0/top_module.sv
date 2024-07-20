module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  reg [1:0] state;

  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= 0;
      f <= 0;
      g <= 0;
    end else begin
      case (state)
        0: begin
          f <= 1;
          state <= 1;
        end
        1: begin
          if (x == 1'b1) begin
            state <= 2;
          end else begin
            state <= 1;
          end
        end
        2: begin
          if (x == 1'b0) begin
            state <= 3;
          end else begin
            state <= 2;
          end
        end
        3: begin
          if (x == 1'b1) begin
            state <= 4;
          end else begin
            state <= 2;
          end
        end
        4: begin
          if (y == 1'b1) begin
            g <= 1;
            state <= 5;
          end else begin
            g <= 0;
            state <= 6;
          end
        end
        5: begin
          if (y == 1'b1) begin
            g <= 1;
            state <= 5;
          end else begin
            g <= 0;
            state <= 6;
          end
        end
        6: begin
          if (y == 1'b1) begin
            g <= 1;
            state <= 5;
          end else begin
            g <= 0;
            state <= 6;
          end
        end
      endcase
    end
  end
endmodule
