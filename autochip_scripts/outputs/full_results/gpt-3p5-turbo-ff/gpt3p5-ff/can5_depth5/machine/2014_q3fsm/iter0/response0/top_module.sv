module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
  
  reg [3:0] state;
  reg [3:0] next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 4'b0000; // state A
    
    else begin
      state <= next_state;
  	
      case (state)
      
        4'b0000: // state A
          if (s) // If s is asserted, next state is B
            next_state = 4'b0010; // state B
          else
            next_state = state; // stay in state A
          
        4'b0010: // state B
          if (w) // If w is asserted, next state is S11
            next_state = 4'b0110; // state S11
          else
            next_state = 4'b0100; // state S10
          
        4'b0100: // state S10
          if (w) // If w is asserted, next state is S21
            next_state = 4'b1010; // state S21
          else
            next_state = 4'b1000; // state S20
          
        4'b0110: // state S11
          if (w) // If w is asserted, next state is S22
            next_state = 4'b1100; // state S22
          else
            next_state = 4'b1010; // state S21
          
        4'b1000: // state S20
          next_state = 4'b0010; // state B
          
        4'b1010: // state S21
          if (w) // If w is asserted, next state is C
            next_state = 4'b0100; // state C
          else
            next_state = 4'b0010; // state B
          
        4'b1100: // state S22
          if (w) // If w is asserted, next state is B
            next_state = 4'b0010; // state B
          else
            next_state = 4'b0100; // state C
          
        default:
          next_state = state;
          
      endcase
      
    end
  end
  
  always @(posedge clk) begin
    if (state == 4'b0010 || state == 4'b0110 || state == 4'b0100 || state == 4'b1010 || state == 4'b1100)
      z <= 1'b1;
    else
      z <= 1'b0;
  end
  
endmodule
