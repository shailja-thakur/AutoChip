module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting
);

  // Define the states as parameters
  parameter S = 0;
  parameter S1 = 1;
  parameter S11 = 2;
  parameter S110 = 3;
  parameter Done = 4;

  // Define the current state and next state variables
  reg [2:0] state;
  reg [2:0] next_state;

  // Assign the next state based on the current state and data input
  always @* begin
    case (state)
      S: begin
        if (data)
          next_state = S1;
        else
          next_state = S;
      end
      S1: begin
        if (data)
          next_state = S11;
        else
          next_state = S;
      end
      S11: begin
        if (data)
          next_state = S11;
        else
          next_state = S110;
      end
      S110: begin
        if (data)
          next_state = Done;
        else
          next_state = S;
      end
      Done: next_state = Done;
    endcase
  end

  // Update the state on the rising edge of clk
  always @(posedge clk) begin
    if (reset)
      state <= S;
    else
      state <= next_state;
  end

  // Assign the output based on the current state
  assign start_shifting = (state == Done) ? 1'b1 : 1'b0;

endmodule
