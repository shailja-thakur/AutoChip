module top_module (
	input clk,
	input in,
	input areset,
	output out
);

  reg [1:0] state;
  reg out;

  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  always @(posedge clk or negedge areset)
  begin
    if (areset == 0)
      state <= A;
    else
    begin
      case (state)
        A: begin
          if (in == 0)
            state <= A;
          else
            state <= B;
          out <= 0;
        end
        B: begin
          if (in == 0)
            state <= C;
          else
            state <= B;
          out <= 0;
        end
        C: begin
          if (in == 0)
            state <= A;
          else
            state <= D;
          out <= 0;
        end
        D: begin
          if (in == 0)
            state <= C;
          else
            state <= B;
          out <= 1;
        end
      endcase
    end
  end
endmodule
