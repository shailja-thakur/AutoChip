module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  // Define the states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  // Declare the state and next_state variables
  reg [1:0] state, next_state;

  // State flip-flop
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= A;
    else
      state <= next_state;
  end

  // State transition logic
  always @(*) begin
    case(state)
      A: begin
        if (r[1] & !r[2] & !r[3])
          next_state = A;
        else if (r[1] & !r[2] & !r[3])
          next_state = B;
        else if (!r[1] & r[2] & !r[3])
          next_state = C;
        else if (!r[1] & !r[2] & !r[3])
          next_state = D;
      end

      B: begin
        if (r[1])
          next_state = B;
        else
          next_state = A;
      end

      C: begin
        if (r[2])
          next_state = C;
        else
          next_state = A;
      end

      default: next_state = A;
    endcase
  end

  // Output assignment
  always @(*) begin
    case(state)
      A: g = 3'b000;
      B: g = 3'b100;
      C: g = 3'b010;
      default: g = 3'b000;
    endcase
  end

endmodule
