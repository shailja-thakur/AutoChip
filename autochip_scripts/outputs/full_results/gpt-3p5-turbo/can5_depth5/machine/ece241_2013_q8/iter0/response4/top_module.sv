module top_module (
  input clk, input aresetn, input x,
  output reg z
);

  // State definition
  reg [3:0] state, next_state;

  // State values
  localparam S = 4'b0000;
  localparam S1 = 4'b0001;
  localparam S10 = 4'b0010;

  // State transition logic
  always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
      state <= S;
    end else begin
      state <= next_state;
    end
  end

  // Next state logic
  always @(state or x) begin
    case (state)
      S: begin
        if (x == 1'b0)
          next_state = S;
        else if (x == 1'b1)
          next_state = S1;
        else
          next_state = S; // default case
      end

      S1: begin
        if (x == 1'b0)
          next_state = S10;
        else if (x == 1'b1)
          next_state = S1;
        else
          next_state = S1; // default case
      end

      S10: begin
        if (x == 1'b0)
          next_state = S;
        else if (x == 1'b1)
          next_state = S1;
        else
          next_state = S10; // default case
      end

      default: next_state = S; // default case
    endcase
  end

  // Output logic
  always @(state) begin
    case (state)
      S, S1: z = 1'b0;
      S10: z = x;
      default: z = 1'b0; // default case
    endcase
  end

endmodule
