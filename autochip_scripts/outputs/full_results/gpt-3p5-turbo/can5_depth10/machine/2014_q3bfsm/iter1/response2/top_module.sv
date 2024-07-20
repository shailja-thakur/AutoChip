module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk or posedge reset)
  begin
    if(reset)
      state <= 3'b000; // state A
    else
    begin
      case(state)
        3'b000: // state A
          begin
            if(x)
              state <= 3'b001; // state B
            else
              state <= 3'b000; // state A
          end
        3'b001: // state B
          begin
            if(x)
              state <= 3'b100; // state E
            else
              state <= 3'b010; // state C
          end
        3'b010: // state C
          begin
            if(x)
              state <= 3'b001; // state B
            else
              state <= 3'b010; // state C
          end
        3'b011: // state D
          begin
            if(x)
              state <= 3'b010; // state C
            else
              state <= 3'b011; // state D
          end
        3'b100: // state E
          begin
            if(x)
              state <= 3'b100; // state E
            else
              state <= 3'b011; // state D
          end
      endcase
    end
  end
  
  always @(state)
  begin
    case(state)
      3'b011, 3'b100: // states D, E
        z = 1'b1; // output high
      default:
        z = 1'b0; // output low
    endcase
  end

endmodule
