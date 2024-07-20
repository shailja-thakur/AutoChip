module top_module (
  input clk,
  input reset,
  input w,
  output z
);
  
  // Define states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  parameter E = 2'b100;
  parameter F = 2'b101;
  
  // Declare state flip-flops
  reg [1:0] current_state;
  reg [1:0] next_state;
  
  // Declare the output
  reg z;
  
  // State table
  always @*
    case(current_state)
      A: next_state = (w) ? B : A;
      B: next_state = (w) ? C : D;
      C: next_state = (w) ? E : D;
      D: next_state = (w) ? F : A;
      E: next_state = (w) ? E : D;
      F: next_state = (w) ? C : D;
      default: next_state = A;
    endcase
  
  // Synchronous state update
  always @(posedge clk, posedge reset)
    if (reset)
      current_state <= A;
    else
      current_state <= next_state;
  
  // Output assignment
  always @*
    case(current_state)
      A: z = 1'b0;
      B: z = 1'b0;
      C: z = 1'b0;
      D: z = 1'b0;
      E: z = 1'b1;
      F: z = 1'b1;
      default: z = 1'b0;
    endcase

endmodule
