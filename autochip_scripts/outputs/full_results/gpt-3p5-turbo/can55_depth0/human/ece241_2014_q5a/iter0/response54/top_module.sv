module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

  reg [3:0] state;
  wire comp;

  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= 0;
    else
    begin
      case (state)
        0: if (x) state <= 1;
        1: state <= 2;
        2: state <= 3;
        3: state <= 4;
        4: state <= 0;
        default: state <= 0;
      endcase
    end
  end

  always @(posedge clk)
  begin
    if (areset)
      z <= 0;
    else
    begin
      case (state)
        0: z <= 0;
        1: z <= 1;
        2: z <= comp;
        3: z <= z + 1;
        4: z <= ~z + 1;
        default: z <= 0;
      endcase
    end
  end

  assign comp = ~x;

endmodule
