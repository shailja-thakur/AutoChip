module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg [1:0] state, next_state;
  reg f_reg, g_reg;
  reg [2:0] x_reg;
  reg y_reg;
  
  // Define states
  localparam A = 2'b00;
  localparam B = 2'b01;
  localparam C = 2'b10;
  localparam D = 2'b11;
  
  // Assign default values
  assign f = f_reg;
  assign g = g_reg;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= A;
      f_reg <= 0;
      g_reg <= 0;
      x_reg <= 3'b000;
      y_reg <= 0;
    end else begin
      state <= next_state;
      f_reg <= f_reg;
      g_reg <= g_reg;
      x_reg <= {x_reg[1:0], x};
      y_reg <= y;
    end
  end
  
  always @(state or x_reg or y_reg) begin
    next_state = state;
    
    case (state)
      A: begin
          if (resetn == 1'b0)
            next_state = A;
          else if (~resetn && (x_reg == 3'b101))
            next_state = B;
        end
      
      B: begin
          if (x_reg == 3'b101)
            next_state = B;
          else if (x_reg == 3'b010)
            next_state = C;
          else
            next_state = A;
        end
      
      C: begin
          if (x_reg == 3'b101)
            next_state = C;
          else if (x_reg == 3'b010)
            next_state = D;
          else
            next_state = A;
        end
      
      D: begin
          if (x_reg == 3'b101)
            next_state = A;
          else if (x_reg == 3'b010)
            next_state = D;
          else
            next_state = A;
        end
      
      default: next_state = A;
    endcase
  end
  
  always @(state or x_reg or y_reg) begin
    case (state)
      A: begin
          f_reg = 1'b0;
          g_reg = 1'b0;
        end
        
      B: begin
          if (x_reg == 3'b010 && y_reg == 1'b1)
            f_reg = 1'b1;
          else
            f_reg = 1'b0;
          g_reg = 1'b0;
        end
        
      C: begin
          f_reg = 1'b0;
          if (y_reg == 1'b1)
            g_reg = 1'b1;
          else
            g_reg = 1'b0;
        end

      D: begin
          f_reg = 1'b0;
          g_reg = 1'b0;
        end
    endcase
  end

endmodule
