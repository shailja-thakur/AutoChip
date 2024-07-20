module top_module (
	input clk,
	input reset,
	input w,
	output z
);
  
  reg [2:0] state;
  wire [2:0] next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
    	state <= 0;
    else
      	state <= next_state;
  end
  
  always @* begin
    case (state)
      3'b000: begin   // State A
        if (w == 1)
          next_state = 3'b001;   // Transition to B
        else
      	  next_state = 3'b000;   // Stay at A
      end
      
      3'b001: begin   // State B
        if (w == 1)
          next_state = 3'b010;   // Transition to C
        else
      	  next_state = 3'b100;   // Transition to D
      end
      
      3'b010: begin   // State C
        if (w == 1)
          next_state = 3'b110;   // Transition to E
        else
      	  next_state = 3'b101;   // Transition to D
      end
      
      3'b100: begin   // State D
        if (w == 1)
          next_state = 3'b011;   // Transition to F
        else
      	  next_state = 3'b000;   // Transition to A
      end
      
      3'b110: begin   // State E
        if (w == 1)
          next_state = 3'b110;   // Stay at E
        else
      	  next_state = 3'b101;   // Transition to D
      end
      
      3'b011: begin   // State F
        if (w == 1)
          next_state = 3'b010;   // Transition to C
        else
      	  next_state = 3'b011;   // Stay at F
      end
      
      default: next_state = 3'b000;
    endcase
  end
  
  assign z = (state == 3'b110) || (state == 3'b011);
  
endmodule
