module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  reg [1:0] state;
  reg f_temp, g_temp;
  
  reg x_1, x_2, x_3, y_1, y_2;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin // State A
          if (!resetn)
            state <= 2'b00;
          else
            state <= 2'b01;
        end
        2'b01: begin // Transition state for f
          state <= 2'b10;
        end
        2'b10: begin // Check if x = 1, 0, 1
          if (x_1 == 1 && x_2 == 0 && x_3 == 1)
            state <= 2'b11;
          else
            state <= 2'b10;
        end
        2'b11: begin // Set g = 1
          state <= 2'b11;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    f_temp <= 0;
    g_temp <= 0;

    case (state)
      2'b01: begin // Transition state for f
        f_temp <= 1;
      end
      2'b11: begin // Set g = 1
        g_temp <= 1;
      end
    endcase
  end

  always @(posedge clk) begin
    x_3 <= x_2;
    x_2 <= x_1;
    x_1 <= x;
  end

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      f <= 0;
    else
      f <= f_temp;
  end

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      g <= 0;
    else
      g <= g_temp;
  end

endmodule
