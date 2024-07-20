module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg [1:0] state, next_state;
  reg f_reg, g_reg, g_latch;
  reg [2:0] x_reg;
  reg [1:0] y_reg;
  
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      state <= 2'b00; // state A
      f_reg <= 1'b0;
      g_reg <= 1'b0;
      g_latch <= 1'b0;
      x_reg <= 3'b0;
      y_reg <= 2'b0;
    end else begin
      state <= next_state;
      f_reg <= f_reg;
      g_reg <= g_latch;
      g_latch <= g_reg;
      x_reg <= {x_reg[1:0], x};
      
      if(state == 2'b00) begin // state A
        if(x_reg == 3'b101) begin
          f_reg <= 1'b1;
          next_state <= 2'b01;
        end else if(x_reg != 3'b000) begin
          f_reg <= 1'b0;
          next_state <= 2'b00;
        end
      end else if(state == 2'b01) begin // state B
        if(x_reg == 3'b101) begin
          f_reg <= 1'b0;
          g_latch <= 1'b1;
          next_state <= 2'b10; // state C
        end else if(x_reg != 3'b000) begin
          f_reg <= 1'b0;
          next_state <= 2'b00; // state A
        end
      end else if(state == 2'b10) begin // state C
        g_latch <= g_reg;
        if(y_reg == 2'b00) begin
          g_reg <= 1'b0;
          next_state <= 2'b00; // state A
        end else if(y_reg == 2'b01) begin
          g_reg <= 1'b1;
          next_state <= 2'b10; // state C
        end
      end
    end
  end
  
  assign f = f_reg;
  assign g = g_reg;
  
endmodule
