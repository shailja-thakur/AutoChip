module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  reg [1:0] state;
  reg [2:0] count_x;
  reg [2:0] count_y;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= 2'b00; // reset
      f <= 0;
      g <= 0;
      count_x <= 0;
      count_y <= 0;
    end else begin
      case (state)
        2'b00: // state A
          begin
            f <= 1;
            state <= 2'b01;
          end
        2'b01: // monitor x
          begin
            if (x == 1) begin
              count_x <= count_x + 1;
              if (count_x == 3) begin
                state <= 2'b10;
                count_x <= 0;
              end
            end else begin
              count_x <= 0;
            end
          end
        2'b10: // maintain g = 1 and monitor y
          begin
            g <= 1;
            if (y == 1) begin
              count_y <= 0;
            end else begin
              count_y <= count_y + 1;
              if (count_y == 2) begin
                g <= 0;
                count_y <= 0;
                state <= 2'b00; // go back to state A
              end
            end
          end
      endcase
    end
  end

endmodule
