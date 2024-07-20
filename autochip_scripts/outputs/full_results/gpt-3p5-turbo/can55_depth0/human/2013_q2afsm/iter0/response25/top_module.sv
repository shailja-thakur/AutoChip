module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [3:1] state, next_state;
  
  always @(posedge clk, negedge resetn)
  begin
    if (!resetn)
      state <= 3'b000;
    else
      state <= next_state;
  end
  
  always @(state, r)
  begin
    case (state)
      3'b000: // State A
      begin
        if (r[1] && r[2] && r[3])
          next_state = 3'b000; // Stay in State A
        else if (r[1] && !r[2] && !r[3])
          next_state = 3'b001; // Transition to State B
        else if (!r[1] && r[2] && !r[3])
          next_state = 3'b010; // Transition to State C
        else if (!r[1] && !r[2] && !r[3])
          next_state = 3'b011; // Transition to State D
        else
          next_state = 3'b000; // Stay in State A
      end
      
      3'b001: // State B
      begin
        if (r[1])
          next_state = 3'b001; // Stay in State B
        else if (!r[1] && !r[2] && !r[3])
          next_state = 3'b000; // Transition to State A
        else
          next_state = 3'b001; // Stay in State B
      end
      
      3'b010: // State C
      begin
        if (r[2])
          next_state = 3'b010; // Stay in State C
        else if (!r[1] && !r[2] && !r[3])
          next_state = 3'b000; // Transition to State A
        else
          next_state = 3'b010; // Stay in State C
      end
      
      3'b011: // State D
      begin
        next_state = 3'b000; // Transition to State A
      end
    endcase
  end
  
  assign g[1] = (state == 3'b001);
  assign g[2] = (state == 3'b010);
  assign g[3] = (state == 3'b000);
  
endmodule
