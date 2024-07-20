module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);
  parameter A = 2'b00;  // Define state A
  parameter B = 2'b01;  // Define state B
  parameter C = 2'b10;  // Define state C
  
  reg [1:0] state;      // Register to store the state of the machine

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= A;       // Reset state to A if areset is triggered
    end else begin     
      case (state)
        A: begin
          state <= (x) ? C : A;   // Set state to C if x is true, otherwise stay at A
        end
        B: begin
          state <= (x) ? B : C;   // Set state to B if x is true, otherwise set to C
        end
        C: begin
          state <= (x) ? B : C;   // Set state to B if x is true, otherwise set to C
        end
      endcase
    end
  end

  assign z = (state == C) ? 1'b1 : 1'b0;   // Set output to true if state is C, otherwise false

endmodule
