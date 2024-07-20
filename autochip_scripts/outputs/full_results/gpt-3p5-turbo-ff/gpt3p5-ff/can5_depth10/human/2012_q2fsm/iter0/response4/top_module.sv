module top_module (
	input clk,
	input reset,
	input w,
	output z
);

  // State enumeration
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  
  // State register and next state logic
  reg [1:0] current_state, next_state;
  
  always @(posedge clk or posedge reset)
  begin
    if (reset)
      current_state <= A;
    else
      current_state <= next_state;
  end
  
  // State transition logic
  always @*
  begin
    case (current_state)
      A: if (w) next_state = B; else next_state = A;
      B: if (w) next_state = C; else next_state = D;
      C: if (w) next_state = E; else next_state = D;
      D: if (w) next_state = F; else next_state = A;
      E: if (z) next_state = E; else next_state = D;
      F: if (z) next_state = C; else next_state = D;
    endcase
  end
  
  // Output logic
  always @*
  begin
    case (current_state)
      E: z = 1;
      default: z = 0;
    endcase
  end

endmodule
