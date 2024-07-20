module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  // Define states
  parameter S0 = 0;
  parameter S1 = 1;
  parameter S2 = 2;
  reg [1:0] state;
  reg [1:0] next_state;

  // Define output logic
  always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
      state <= S0;
      z <= 0;
    end else begin
      state <= next_state;
      if (state == S2) begin
        z <= 1;
      end else begin
        z <= 0;
      end
    end
  end

  // Define next state logic and sequence detection
  always @(*) begin
    next_state = state;
    case (state)
      S0: begin
        if (x == 1'b1) begin
          next_state = S1;
        end
        else begin
          next_state = S0;
        end
      end
      S1: begin
        if (x == 1'b0) begin
          next_state = S0;
        end else if (x == 1'b1) begin
          next_state = S2;
        end
      end
      S2: begin
        if (x == 1'b1) begin
          next_state = S0;
        end else if (x == 1'b0) begin
          next_state = S1;
        end
      end
    endcase
  end

endmodule
