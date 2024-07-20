module top_module (
	input clk,
	input reset,
	input w,
	output z
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
    else if (w)
    begin
      case (state)
        A: state <= B;
        B: state <= C;
        C: state <= E;
        D: state <= F;
        E: state <= E;
        F: state <= C;
      endcase
    end
    else
    begin
      case (state)
        A: state <= A;
        B: state <= D;
        C: state <= D;
        D: state <= A;
        E: state <= D;
        F: state <= D;
      endcase
    end
  end
  
  always @(state)
  begin
    case (state)
      A: z = 1'b0;
      B: z = 1'b0;
      C: z = 1'b1;
      D: z = 1'b0;
      E: z = 1'b1;
      F: z = 1'b1;
      default: z = 1'b0;
    endcase
  end
  
endmodule
