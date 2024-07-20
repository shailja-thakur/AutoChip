module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  // Define the states
  parameter S = 2'b00;
  parameter S1 = 2'b01;
  parameter S10 = 2'b10;

  reg [1:0] state;
  reg [1:0] next_state;

  // Initial state and next state
  always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
      state <= S;
      next_state <= S;
    end
    else begin
      state <= next_state;
      case (state)
        S: begin
          if (x == 1)
            next_state <= S1;
          else
            next_state <= S;
        end
        S1: begin
          if (x == 0)
            next_state <= S10;
          else
            next_state <= S1;
        end
        S10: begin
          if (x == 1)
            next_state <= S1;
          else
            next_state <= S;
        end
      endcase
    end
  end

  // Output z
  always @(state) begin
    case (state)
      S, S1: z = 0;
      S10: z = x;
    endcase
  end

endmodule
