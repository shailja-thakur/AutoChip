module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  // Define the parameter values A, B, and C
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;

  // Register to store the state of the machine
  reg [1:0] state;

  always @(posedge clk or posedge areset) begin
    // Reset condition
    if (areset) begin
      state <= A;
    end
    else begin
      // Case statement to determine the state
      case(state)
        A: begin
          if (x) begin
            state <= C;
          end
          else begin
            state <= A;
          end
        end
        B: begin
          if (x) begin
            state <= B;
          end
          else begin
            state <= C;
          end
        end
        C: begin
          if (x) begin
            state <= B;
          end
          else begin
            state <= C;
          end
        end
        default: begin
          state <= A;
        end
      endcase
    end
  end

  // Output assignment based on the state
  assign z = (state == C) ? 1'b1 : 1'b0;

endmodule
