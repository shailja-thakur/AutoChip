module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

  // Declare states as enum
  typedef enum {S, S1, S10} state_type;
  reg state, next_state;
  
  // State assignment based on input conditions
  always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
      state <= S;
    else
      state <= next_state;
  end
  
  // Next state assignment based on current state and input conditions
  always @(*) begin
    case(state)
      S: begin
        if (x == 0)
          next_state = S;
        else
          next_state = S1;
      end
      S1: begin
        if (x == 0)
          next_state = S10;
        else
          next_state = S1;
      end
      S10: begin
        if (x == 0)
          next_state = S;
        else
          next_state = S1;
      end
      default: next_state = S; // default case
    endcase
  end
  
  // Output assignment based on current state
  always @(*) begin
    case(state)
      S, S1: z = 0;
      S10: z = x;
      default: z = 0; // default case
    endcase
  end
  
endmodule
