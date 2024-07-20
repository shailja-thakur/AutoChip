module top_module (
	input clk,
	input reset,
	input w,
	output z
);

  reg [2:0] state;
  reg [2:0] next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) 
      state <= 3'b000; // initial state is A
      
    else 
      state <= next_state;
  end
  
  always @(state or w) begin
    case (state)
      3'b000: begin // state A
        if (w)
          next_state = 3'b000; // transition to state A
        else
          next_state = 3'b001; // transition to state B
      end
      
      3'b001: begin // state B
        if (w)
          next_state = 3'b010; // transition to state C
        else
          next_state = 3'b011; // transition to state D
      end
      
      3'b010: begin // state C
        if (w)
          next_state = 3'b110; // transition to state E
        else
          next_state = 3'b011; // transition to state D
      end
      
      3'b011: begin // state D
        if (w)
          next_state = 3'b100; // transition to state F
        else
          next_state = 3'b000; // transition to state A
      end
      
      3'b100: begin // state E
        if (w)
          next_state = 3'b100; // transition to state F
        else
          next_state = 3'b011; // transition to state D
      end
      
      3'b101: begin // state F
        if (w)
          next_state = 3'b010; // transition to state C
        else
          next_state = 3'b011; // transition to state D
      end
      
      default: next_state = 3'b000; // default state is A
    endcase
  end
  
  always @(posedge clk) begin
    if (state == 3'b101) // state F
      z <= 1'b1;
    else
      z <= 1'b0;
  end
  
endmodule
