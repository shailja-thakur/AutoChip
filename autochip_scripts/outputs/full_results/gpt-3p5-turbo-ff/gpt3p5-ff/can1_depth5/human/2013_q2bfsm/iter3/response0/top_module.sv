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
      state <= 2'b00;
    else
      case (state)
        2'b00: // State A
          begin
            if (~resetn)
              state <= 2'b00;
            else if (x == 1 && x_prev == 0 && x_prev_prev == 1)
              state <= 2'b01;
          end;
        
        2'b01: // State B
          begin
            if (y == 1 && y_prev == 0 && y_prev_prev == 1)
              state <= 2'b10;
            else if (clk)
              state <= 2'b01;
          end;
        
        2'b10: // State C
          begin
            if (y == 1)
              state <= 2'b10;
            else
              state <= 2'b00;
          end;
      endcase;
  end

  always @(posedge clk)
  begin
    f <= (state == 2'b00) ? 1'b0 : 1'b1;
  end

  always @(posedge clk)
  begin
    case (state)
      2'b00: // State A
        g <= 1'b0;
      
      2'b01: // State B
        g <= 1'b1;
      
      2'b10: // State C
        if (y == 1) 
          g <= 1'b1;
        else
          g <= 1'b0;
    endcase;
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
