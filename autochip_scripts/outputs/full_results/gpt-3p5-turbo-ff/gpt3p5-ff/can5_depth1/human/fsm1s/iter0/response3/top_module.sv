module top_module (
  input wire clk,
  input wire in,
  input wire reset,
  output wire out
);

  reg [1:0] state, next_state;
  reg out_reg;
  
  parameter B = 2'b00;
  parameter A = 2'b01;

  always @(posedge clk) begin
    if (reset)
      state <= B;
    else
      state <= next_state;
  end

  always @(state, in) begin
    case (state)
      B: begin
        if (in)
          next_state = B;
        else
          next_state = A;
      end

      A: begin
        if (in)
          next_state = A;
        else
          next_state = B;
      end

      default: next_state = B;
    end
  end

  always @(state) begin
    case (state)
      B: out_reg = 1'b1;

      A: out_reg = 1'b0;

      default: out_reg = 1'b1;
    end
  end

  assign out = out_reg;

endmodule
