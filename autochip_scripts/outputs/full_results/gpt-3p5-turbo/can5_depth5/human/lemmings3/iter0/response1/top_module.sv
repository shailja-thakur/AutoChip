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

  reg [1:0] state;
  reg [1:0] next_state;
  reg walk_left;
  reg walk_right;
  reg aaah;
  reg digging;

  always @(posedge clk or posedge areset) begin
    // Asynchronous reset
    if (areset) begin
      state <= 2'b00; // Initialize to walking left
    end 
    else begin
      state <= next_state;
    end
  end

  always @(*) begin
    // Default assignment
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;
    
    case (state)
      2'b00: begin // Walking left
        walk_left = 1'b1;
        if (bump_right) begin
          next_state = 2'b01; // Switch to walking right
          walk_left = 1'b0;
        end
        else if (ground == 0) begin
          next_state = 2'b10; // Fall
        end
        else if (dig) begin
          next_state = 2'b11; // Start digging
        end
      end
      
      2'b01: begin // Walking right
        walk_right = 1'b1;
        if (bump_left) begin
          next_state = 2'b00; // Switch to walking left
          walk_right = 1'b0;
        end
        else if (ground == 0) begin
          next_state = 2'b10; // Fall
        end
        else if (dig) begin
          next_state = 2'b11; // Start digging
        end
      end
      
      2'b10: begin // Falling
        aaah = 1'b1;
        if (ground == 1) begin
          if (state == 2'b00) begin
            next_state = 2'b00; // Resume walking left
          end
          else if (state == 2'b01) begin
            next_state = 2'b01; // Resume walking right
          end
          aaah = 1'b0;
        end
      end
      
      2'b11: begin // Digging
        digging = 1'b1;
        if (ground == 0) begin
          next_state = 2'b10; // Fall
          digging = 1'b0;
        end
        else if (state == 2'b00) begin
          next_state = 2'b00; // Resume walking left
        end
        else if (state == 2'b01) begin
          next_state = 2'b01; // Resume walking right
        end
      end
    endcase
  end

endmodule
