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
      state <= 3'b001; // state A
    else
    begin
      case(state)
        3'b001: // state A
        begin
          if(x)
            state <= 3'b010; // state B
          else
            state <= 3'b001; // state A
        end
        3'b010: // state B
        begin
          if(x)
            state <= 3'b110; // state E
          else
            state <= 3'b010; // state B
        end
        3'b110: // state E
        begin
          if(x)
            state <= 3'b110; // state E
          else
            state <= 3'b101; // state D
        end
        3'b101: // state D
        begin
          if(x)
            state <= 3'b100; // state C
          else
            state <= 3'b010; // state B
        end
        3'b100: // state C
        begin
          if(x)
            state <= 3'b010; // state B
          else
            state <= 3'b101; // state D
        end
        default:
          state <= 3'b001; // state A
      endcase
    end
  end

  always @(state)
  begin
    case(state)
      3'b110, 3'b101: // states E, D
        z <= 1'b1; // output high
      default:
        z <= 1'b0; // output low
    endcase
  end
endmodule
