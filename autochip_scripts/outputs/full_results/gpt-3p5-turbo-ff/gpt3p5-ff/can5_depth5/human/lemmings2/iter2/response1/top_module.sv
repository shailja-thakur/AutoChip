module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output reg walk_left,
  output reg walk_right,
  output reg aaah);
  
  reg [1:0] state;
  reg [1:0] next_state;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00;
    else
      state <= next_state;
  end
  
  always @* begin
    next_state = state;
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    
    case (state)
      2'b00: begin
        if (bump_left && !bump_right)
          next_state = 2'b10;
        else if (!bump_left && bump_right)
          next_state = 2'b11;
        else if (bump_left && bump_right)
          next_state = 2'b01;
        
        if (ground == 1'b0)
          aaah = 1'b1;
        
        if (next_state == 2'b00)
          walk_left = 1'b1;
        else if (next_state == 2'b10)
          walk_right = 1'b1;
        else if (next_state == 2'b11)
          walk_left = 1'b1;
      end
      
      2'b01: begin
        aaah = 1'b1;
        walk_left = 1'b1;
        
        if (ground == 1'b1)
          next_state = 2'b00;
      end
      
      2'b10: begin
        walk_right = 1'b1;
        
        if (ground == 1'b1)
          next_state = 2'b00;
      end
      
      2'b11: begin
        walk_left = 1'b1;
        
        if (ground == 1'b1)
          next_state = 2'b00;
      end
    endcase
  end

endmodule
