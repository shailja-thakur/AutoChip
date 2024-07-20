module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

  parameter [2:0]
  S_WALK_L = 3'b000,
  S_WALK_R = 3'b001,
  S_FALL = 3'b010,
  S_DIG = 3'b011,
  S_SPLATTER = 3'b100;
  
  reg [2:0] state, next_state;
  reg walk_left, walk_right, aaah, digging;
  reg [4:0] fall_cnt;
  
  always @(posedge clk, posedge areset) begin
    if (areset)
      state <= S_WALK_L;
    else 
      state <= next_state;    
  end
  
  always @* begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;
    
    case(state)
      S_WALK_L: begin
        if (bump_right)
          next_state = S_WALK_R;
        else if (ground == 0) 
          next_state = S_FALL;
        else if (dig)
          next_state = S_DIG;
          
        walk_left = 1;
      end
      S_WALK_R: begin
        if (bump_left)
          next_state = S_WALK_L;
        else if (ground == 0) 
          next_state = S_FALL;
        else if (dig)
          next_state = S_DIG;
           
        walk_right = 1;
      end
      S_FALL: begin
        if (ground == 1) 
          next_state = state;
        else if (dig)
          next_state = S_DIG;
        else if (fall_cnt >= 20)
          next_state = S_SPLATTER;
        
        aaah = 1;
        fall_cnt = fall_cnt + 1;
      end
      S_DIG: begin
        if (ground == 0)
          next_state = S_FALL;
        else if (!dig)
          next_state = S_WALK_L;
        
        digging = 1;
      end
      S_SPLATTER: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end
    endcase
  end
  
endmodule
