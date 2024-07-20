module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

  reg [1:0] state, next_state;

  parameter [1:0] A = 2'b00;
  parameter [1:0] B = 2'b01;
  parameter [1:0] C = 2'b10;
  parameter [1:0] D = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  always @(state, in) begin
    case (state)
      A: begin
        if (in)
          next_state = B;
        else
          next_state = A;
        out = 0;
      end
      B: begin
        if (in)
          next_state = C;
        else
          next_state = B;
        out = 0;
      end
      C: begin
        if (in)
          next_state = D;
        else
          next_state = A;
        out = 0;
      end
      D: begin
        if (in)
          next_state = B;
        else
          next_state = C;
        out = 1;
      end
      default: begin
        next_state = A;
        out = 0;
      end
    endcase
  end
endmodule
