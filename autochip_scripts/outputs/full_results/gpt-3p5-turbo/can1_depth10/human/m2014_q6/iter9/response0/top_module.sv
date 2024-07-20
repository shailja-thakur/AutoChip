module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [1:0] state;
  reg E, F; // Add registers for state E and F
  
  // Define states
  localparam A = 2'b00;
  localparam B = 2'b01;
  localparam C = 2'b10;
  localparam D = 2'b11;
  
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
          else if (E) // Check E state instead of z
            state <= E;
          else
            state <= D;
        D:
          if (w)
            state <= A;
          else if (F) // Check F state instead of z
            state <= F;
          else
            state <= C;
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
  
  always @(state or w or E or F) // Include E and F in sensitivity list
  begin
    case (state)
      A: z = 1'b0;
      B: z = 1'b0;
      C: z = 1'b0;
      D: z = 1'b0;
      E: z = (E) ? 1'b1 : 1'b0;
      F: z = (F) ? 1'b1 : 1'b0;
    endcase
  end
endmodule
