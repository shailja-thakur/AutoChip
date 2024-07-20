module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output reg walk_left,
  output reg walk_right,
  output reg aaah,
  output reg digging
);
   
  reg [4:0] state;
  reg [4:0] next_state;
   
  localparam idle = 3'b001;
  localparam walking_left = 3'b010;
  localparam walking_right = 3'b011;
  localparam falling = 3'b100;
  localparam digging_state = 3'b101;
   
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= idle;
    end else begin
      state <= next_state;
    end
  end
   
  always @(state or bump_left or bump_right or ground or dig) begin
    next_state = state;
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;
    
    case (state)
      idle: begin
        if (ground == 1'b0) begin
          next_state = falling;
          aaah = 1'b1;
        end else begin
          if (bump_left == 1'b1) begin
            next_state = walking_right;
            walk_right = 1'b1;
          end else if (bump_right == 1'b1) begin
            next_state = walking_left;
            walk_left = 1'b1;
          end else if (dig == 1'b1 && ground == 1'b1) begin
            next_state = digging_state;
            digging = 1'b1;
          end
        end
      end
      
      walking_left: begin
        if (bump_left == 1'b1) begin
          next_state = walking_right;
          walk_right = 1'b1;
        end else if (ground == 1'b0) begin
          next_state = falling;
          aaah = 1'b1;
        end
      end
      
      walking_right: begin
        if (bump_right == 1'b1) begin
          next_state = walking_left;
          walk_left = 1'b1;
        end else if (ground == 1'b0) begin
          next_state = falling;
          aaah = 1'b1;
        end
      end
      
      falling: begin
        if (ground == 1'b1) begin
          if (state == falling) begin
            if (bump_left == 1'b1 || bump_right == 1'b1) begin
              next_state = state;
            end else begin
              if (walk_left == 1'b1) begin
                next_state = walking_left;
                walk_left = 1'b1;
              end else if (walk_right == 1'b1) begin
                next_state = walking_right;
                walk_right = 1'b1;
              end
            end
          end else begin
            if (bump_left == 1'b1) begin
              next_state = walking_right;
              walk_right = 1'b1;
            end else if (bump_right == 1'b1) begin
              next_state = walking_left;
              walk_left = 1'b1;
            end else if (dig == 1'b1) begin
              next_state = digging_state;
              digging = 1'b1;
            end else begin
              if (walk_left == 1'b1) begin
                next_state = walking_left;
                walk_left = 1'b1;
              end else if (walk_right == 1'b1) begin
                next_state = walking_right;
                walk_right = 1'b1;
              end
            end
          end
        end
      end
      
      digging_state: begin
        if (ground == 1'b1) begin
          if (bump_left == 1'b1) begin
            next_state = walking_right;
            walk_right = 1'b1;
          end else if (bump_right == 1'b1) begin
            next_state = walking_left;
            walk_left = 1'b1;
          end else begin
            if (walk_left == 1'b1) begin
              next_state = walking_left;
              walk_left = 1'b1;
            end else if (walk_right == 1'b1) begin
              next_state = walking_right;
              walk_right = 1'b1;
            end
          end
        end else begin
          if (dig == 1'b1 && walk_left == 1'b1) begin
            next_state = digging_state;
            digging = 1'b1;
          end else if (dig == 1'b1 && walk_right == 1'b1) begin
            next_state = digging_state;
            digging = 1'b1;
          end
        end
      end
    endcase
  end
endmodule
