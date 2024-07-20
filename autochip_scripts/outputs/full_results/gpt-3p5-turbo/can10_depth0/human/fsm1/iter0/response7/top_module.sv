module top_module (
	input clk,
	input in,
	input areset,
	output out
);

  reg [1:0] state, next_state;
  
  parameter B = 2'b00;
  parameter A = 2'b01;
   
  // State register
  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= B;
    else
      state <= next_state;
  end
  
  // Next-state logic
  always @(*)
  begin
    case(state)
      B: if (in) next_state = B; else next_state = A;
      A: if (in) next_state = A; else next_state = B;
      default: next_state = B;
    endcase
  end
  
  // Output logic
  always @(state)
  begin
    case(state)
      B: out = 1'b1;
      A: out = 1'b0;
      default: out = 1'b0;
    endcase
  end
  
endmodule
