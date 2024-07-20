module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  reg [6:0] next_state;
  
  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  parameter E = 3'b100;
  parameter F = 3'b101;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  
  always @(*) begin
    case(state)
      A: begin
        if (w == 1'b0)
          next_state = B;
        else
          next_state = A;
      end
      B: begin
        if (w == 1'b0)
          next_state = C;
        else
          next_state = D;
      end
      C: begin
        if (w == 1'b0)
          next_state = E;
        else
          next_state = D;
      end
      D: begin
        if (w == 1'b0)
          next_state = F;
        else
          next_state = A;
      end
      E: begin
        if (w == 1'b0)
          next_state = E;
        else
          next_state = D;
      end
      F: begin
        if (w == 1'b0)
          next_state = C;
        else
          next_state = D;
      end
      default: next_state = A;
    endcase
  end
  
  always @(posedge clk) begin
    case(state)
      E: begin
        if (w == 1'b0)
          z <= 1'b1;
        else
          z <= 1'b0;
      end
      F: begin
        if (w == 1'b0)
          z <= 1'b0;
        else
          z <= 1'b1;
      end
      default: z <= 1'b0;
    endcase
  end
  
endmodule
