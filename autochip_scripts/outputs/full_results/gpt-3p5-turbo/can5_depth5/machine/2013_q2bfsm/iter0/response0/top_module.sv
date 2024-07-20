module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);
  reg [3:0] state, next_state;
  
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter S0 = 2'b10;
  parameter S1 = 2'b11;
  parameter S10 = 2'b100;
  parameter G1 = 2'b101;
  parameter G2 = 2'b110;
  parameter P0 = 2'b111;
  parameter P1 = 2'b000;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= A;
      f <= 0;
      g <= 0;
    end else begin
      state <= next_state;
      f <= (state == B) ? 1'b1 : 1'b0;
      g <= (state == G1 || state == G2 || state == P1) ? 1'b1 : 1'b0;
    end
  end
  
  always @(state or x or y) begin
    case (state)
      A: begin
        if (x)
          next_state = B;
        else
          next_state = S0;
      end
      B: begin
        next_state = S0;
      end
      S0: begin
        if (x)
          next_state = S1;
        else
          next_state = S0;
      end
      S1: begin
        if (x)
          next_state = S1;
        else
          next_state = S10;
      end
      S10: begin
        if (x)
          next_state = G1;
        else
          next_state = S0;
      end
      G1: begin
        if (y)
          next_state = P1;
        else
          next_state = G2;
      end
      G2: begin
        if (y)
          next_state = P1;
        else
          next_state = P0;
      end
      P0: begin
        next_state = P0;
      end
      P1: begin
        next_state = P1;
      end
      default: next_state = A;
    endcase
  end

endmodule
