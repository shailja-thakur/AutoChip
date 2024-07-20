module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  // Define parameter values
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;

  // State register to store the current state of the machine
  reg [1:0] state;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= A; // Set the state to A on reset
    else begin
      case (state)
        A: state <= (x) ? C : A; // Set state to C if x is true, otherwise stay in state A
        B: state <= (x) ? B : C; // Set state to B if x is true, otherwise set state to C
        C: state <= (x) ? B : C; // Set state to B if x is true, otherwise set state to C
      endcase
    end
  end

  assign z = (state == C) ? 1'b1 : 1'b0; // Output z is true if state is C, otherwise false

endmodule
