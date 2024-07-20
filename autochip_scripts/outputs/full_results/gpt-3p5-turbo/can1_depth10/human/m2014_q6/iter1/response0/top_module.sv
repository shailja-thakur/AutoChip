module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);
  
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  
  reg [1:0] state;
  
  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= A;
    else
    begin
      case (state)
        A:
          if (w)
            state <= A;
          else
            state <= B;
        B:
          if (w)
            state <= D;
          else
            state <= C;
        C:
          if (w)
            state <= D;
          else
            state <= E;
        D:
          if (w)
            state <= A;
          else
            state <= F;
        E:
          if (w)
            state <= D;
          else
            state <= E;
        F:
          if (w)
            state <= D;
          else
            state <= C;
      endcase
    end
  end
  
  always @(state)
  begin
    case (state)
      A: z <= 1'b0;
      B: z <= 1'b0;
      C: z <= 1'b0;
      D: z <= 1'b0;
      E: z <= 1'b1;
      F: z <= 1'b1;
    endcase
  end
  
endmodule
