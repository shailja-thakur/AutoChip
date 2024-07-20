module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

  reg [1:0] state;
  parameter B = 2'b00, A = 2'b01;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= B;
    else begin
      case (state)
        B: begin
          if (in)
            state <= A;
          else
            state <= B;
        end
        A: begin
          if (in)
            state <= A;
          else
            state <= B;
        end
      endcase
    end
  end
  
  always @(state) begin
    case (state)
      B: out <= 1'b1;
      A: out <= 1'b0;
    endcase
  end
  
endmodule
