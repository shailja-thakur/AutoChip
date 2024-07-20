module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  parameter A = 2'b00;  // Define state A
  parameter B = 2'b01;  // Define state B

  reg [1:0] state;  // Register to store state

  always @(posedge clk or posedge areset)
    if (areset)
      state <= A;  // Reset state to A
    else begin
      case (state)
        A: begin
          if (x)
            state <= B;  // Transition to state B if x is high
          else
            state <= A;  // Remain in state A if x is low
        end
        B: begin
          state <= B;  // Remain in state B
        end
      endcase
    end

  assign z = (state == A && x) || (state == B && ~x) ? 1'b1 : 1'b0;  // Set output z

endmodule
