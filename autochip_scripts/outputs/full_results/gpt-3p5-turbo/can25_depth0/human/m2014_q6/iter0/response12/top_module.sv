module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= 3'b000;
    else
    begin
      case (state)
        3'b000:
          if (w == 1'b0)
            state <= 3'b001;
          else if (w == 1'b1)
            state <= 3'b000;
        3'b001:
          if (w == 1'b0)
            state <= 3'b010;
          else if (w == 1'b1)
            state <= 3'b011;
        3'b010:
          if (w == 1'b0)
            state <= 3'b110;
          else if (w == 1'b1)
            state <= 3'b011;
        3'b011:
          if (w == 1'b0)
            state <= 3'b100;
          else if (w == 1'b1)
            state <= 3'b000;
        3'b100:
          if (w == 1'b0)
            state <= 3'b100;
          else if (w == 1'b1)
            state <= 3'b011;
      endcase
    end
  end

  always @(state)
  begin
    case (state)
      3'b000:
        z <= 1'b0;
      3'b001:
        z <= 1'b1;
      3'b010:
        z <= 1'b0;
      3'b011:
        z <= 1'b1;
      3'b100:
        z <= 1'b1;
      default:
        z <= 1'b0;
    endcase
  end
  
endmodule
