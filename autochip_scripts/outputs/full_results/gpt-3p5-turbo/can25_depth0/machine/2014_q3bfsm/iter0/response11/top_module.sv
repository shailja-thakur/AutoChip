module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] state;
  reg [2:0] next_state;

  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  parameter E = 3'b100;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= A;
    else
      state <= next_state;
  end

  always @* begin
    case (state)
      A:
        if (x)
          next_state = B;
        else
          next_state = A;

      B:
        if (x)
          next_state = E;
        else
          next_state = B;

      C:
        if (x)
          next_state = B;
        else
          next_state = C;

      D:
        if (x)
          next_state = C;
        else
          next_state = B;

      E:
        if (x)
          next_state = E;
        else
          next_state = D;

      default:
        next_state = A;
    endcase
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      z <= 0;
    else begin
      if (state == D || state == E)
        z <= 1;
      else
        z <= 0;
    end
  end

endmodule
