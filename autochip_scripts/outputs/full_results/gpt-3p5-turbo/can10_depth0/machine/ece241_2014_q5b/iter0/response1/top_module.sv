module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

  reg [1:0] state;
  parameter A = 2'b00;
  parameter B = 2'b01;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= A;
    end
    else begin
      case (state)
        A: begin
          if (x) begin
            state <= B;
          end
          else begin
            state <= A;
          end
        end
        B: begin
          state <= B;
        end
      endcase
    end
  end

  always @(state or x) begin
    if (state == A && x) begin
      z <= 1;
    end
    else if (state == B && !x) begin
      z <= 1;
    end
    else begin
      z <= 0;
    end
  end

endmodule
