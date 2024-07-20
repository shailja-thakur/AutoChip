module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  // Define the states
  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  parameter E = 3'b100;
  parameter F = 3'b101;

  reg [2:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= A;
    else begin
      case (state)
        A: state <= w ? B : A;
        B: state <= w ? C : D;
        C: state <= w ? E : D;
        D: state <= w ? F : A;
        E: state <= w ? E : D;
        F: state <= w ? C : D;
      endcase
    end
  end
  
  always @(state) begin
    case (state)
      A: z = 0;
      B: z = 0;
      C: z = 0;
      D: z = 0;
      E: z = 1;
      F: z = 1;
    endcase
  end
endmodule
