module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] present_state, next_state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      present_state <= 3'b000;
    else
      present_state <= next_state;
  end

  always @(*) begin
    case (present_state)
      3'b000:
        if (x)
          next_state = 3'b001;
        else
          next_state = 3'b000;
      3'b001:
        if (x)
          next_state = 3'b100;
        else
          next_state = 3'b001;
      3'b010:
        if (x)
          next_state = 3'b001;
        else
          next_state = 3'b010;
      3'b011:
        if (x)
          next_state = 3'b010;
        else
          next_state = 3'b001;
      3'b100:
        if (x)
          next_state = 3'b100;
        else
          next_state = 3'b011;
      default:
        next_state = 3'b000;
    endcase
  end

  always @(present_state) begin
    case (present_state)
      3'b011:
        z <= 1'b1;
      3'b100:
        z <= 1'b1;
      default:
        z <= 1'b0;
    endcase
  end

endmodule
