module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  reg [1:0] state;
  reg x_prev, x_prev_prev;
  reg y_prev, y_prev_prev;

  always @(posedge clk or negedge resetn)
  begin
    if (~resetn)
      state <= 2'b0;
    else
      case (state)
        2'b0: // State A
          begin
            if (~resetn)
              state <= 2'b0;
            else if (x == 1 && x_prev == 0 && x_prev_prev == 1)
              state <= 2'b1;
          end
        
        2'b1: // State B
          begin
            if (y == 1 && y_prev == 0 && y_prev_prev == 1)
              state <= 2'b2;
            else if (clk)
              state <= 2'b1;
          end
        
        2'b2: // State C
          begin
            state <= 2'b2;
          end
      endcase
  end

  always @(posedge clk)
  begin
    f <= (state == 2'b0) ? 1'b0 : 1'b1;
  end

  always @(posedge clk)
  begin
    case (state)
      2'b0: // State A
        begin
          g <= 1'b0;
        end
      
      2'b1: // State B
        begin
          g <= 1'b1;
        end
      
      2'b2: // State C
        begin
          if (y == 1) 
            g <= 1'b1;
          else
            g <= 1'b0;
        end
    endcase
  end

  always @(posedge clk)
  begin
    x_prev_prev <= x_prev;
    x_prev <= x;
  end

  always @(posedge clk)
  begin
    y_prev_prev <= y_prev;
    y_prev <= y;
  end
  
endmodule
