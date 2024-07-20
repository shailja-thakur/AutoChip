module top_module(
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
  reg [4:0] timer;
  reg splat;
  
  // Resetting the Lemming machine to walk left on positive edge of asynchronous reset
  always @(posedge areset)
    state <= 2'b01;
    
  always @(posedge clk) begin
    // State machine
    case(state)
      2'b01: begin
        // Walking left state
        if(bump_left)
          state <= 2'b10;
        else if(ground)
          state <= 2'b01;
        else if(timer >= 5'd20)
          splat <= 1'b1;
      end
      2'b10: begin
        // Walking right state
        if(bump_right)
          state <= 2'b01;
        else if(ground)
          state <= 2'b10;
        else if(timer >= 5'd20)
          splat <= 1'b1;
      end
    endcase
    
    // Timer incrementation
    if(state == 2'b01 || state == 2'b10)
      timer <= timer + 1'd1;
    else
      timer <= 5'd0;
  end
  
  // Output assignment
  assign walk_left = (state == 2'b01 && !splat);
  assign walk_right = (state == 2'b10 && !splat);
  assign aaah = (state == 2'b01 && !ground && !splat);
  assign digging = (state == 2'b01 && dig && ground && !splat);
endmodule
