module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  // Parameter for defining machine states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;

  // Register to store the state of the machine
  reg [1:0] state;

  // Always block triggered on the positive edge of the clock and reset signal
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset signal triggered, set state to A
      state <= A;
    end else begin
      // Determine the state based on the current state and input x
      case (state)
        A: begin
          if (x) begin
            state <= C;
          end else begin
            state <= A;
          end
        end
        B: begin
          if (x) begin
            state <= B;
          end else begin
            state <= C;
          end
        end
        C: begin
          if (x) begin
            state <= B;
          end else begin
            state <= C;
          end
        end
      endcase
    end
  end

  // Output assignment based on the current state
  assign z = (state == C) ? 1'b1 : 1'b0;

endmodule
