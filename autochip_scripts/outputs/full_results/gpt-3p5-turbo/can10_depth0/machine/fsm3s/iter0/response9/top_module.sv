module top_module(
  input clk,
  input in,
  input reset,
  output reg out
  );

  // Define the states as constants
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  // Define the state variable and initialize it to A
  reg [1:0] state = A;

  // Define the next state variable
  reg [1:0] next_state;

  // Define the state transition logic
  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= A;
    else
      state <= next_state;
  end

  // Define the next state logic
  always @*
  begin
    case (state)
      A:
        begin
          if (in)
            next_state = B;
          else
            next_state = A;
        end
      
      B:
        begin
          if (in)
            next_state = B;
          else
            next_state = C;
        end
      
      C:
        begin
          if (in)
            next_state = D;
          else
            next_state = A;
        end
      
      D:
        begin
          if (in)
            next_state = B;
          else
            next_state = C;
        end
    endcase
  end

  // Define the output logic
  always @(state)
  begin
    if (state == D)
      out = 1;
    else
      out = 0;
  end
  
endmodule
