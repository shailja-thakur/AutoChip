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
  reg [1:0] next_state; // Added next state variable
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00;
    else
      state <= next_state; // Assign next state to current state at positive edge of clock
  end
  
  always @* begin // Use always @* for combinational logic
    aaah = 1'b0; // Reset aaah to 0 at each clock cycle
    walk_left = 1'b0; // Reset walk_left to 0 at each clock cycle
    walk_right = 1'b0; // Reset walk_right to 0 at each clock cycle
    
    case (state)
      2'b00: begin
        if (bump_left && bump_right)
          next_state = 2'b01;
        else if (bump_left)
          next_state = 2'b10;
        else if (bump_right)
          next_state = 2'b11;
        else
          next_state = 2'b00;
      end
      
      2'b01: begin
        aaah = 1'b1;
        
        if (ground)
          next_state = 2'b00;
        else
          next_state = 2'b01;
      end

      2'b10: begin
        walk_right = 1'b1;
        
        if (ground)
          next_state = 2'b00;
        else
          next_state = 2'b10;
      end

      2'b11: begin
        walk_left = 1'b1;
        
        if (ground)
          next_state = 2'b00;
        else
          next_state = 2'b11;
      end
    endcase
  end
  
  initial begin
    walk_left <= 1'b1;
    walk_right <= 1'b0;
    aaah <= 1'b0;
  end

endmodule
