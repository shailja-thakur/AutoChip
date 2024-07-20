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
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b01; // Reset to state 01 (falling) on asynchronous reset
    else begin
      case (state)
        2'b00: begin
          walk_left <= 1'b1;
          walk_right <= 1'b0;
          aaah <= 1'b0;
          
          if (bump_left && !bump_right)
            state <= 2'b10;
          else if (!bump_left && bump_right)
            state <= 2'b11;
          else if (bump_left && bump_right)
            state <= 2'b01;
        end
        
        2'b01: begin
          walk_left <= 1'b1;
          walk_right <= 1'b0;
          aaah <= 1'b1;
          
          if (ground)
            state <= 2'b00;
        end

        2'b10: begin
          walk_left <= 1'b0;
          walk_right <= 1'b1;
          aaah <= 1'b0;
          
          if (ground)
            state <= 2'b00;
        end

        2'b11: begin
          walk_left <= 1'b1;
          walk_right <= 1'b0;
          aaah <= 1'b0;
          
          if (ground)
            state <= 2'b00;
        end
      endcase
    end
  end
  
endmodule
