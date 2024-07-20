module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state, next_state;

  parameter B = 2'b00;
  parameter A = 2'b01;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= B;
    end else begin
      state <= next_state;
    end
  end

  always @(state or in) begin
    case (state)
      B: begin
        if (in == 1'b0) begin
          next_state = A;
        end else begin
          next_state = B;
        end
      end
      A: begin
        if (in == 1'b0) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
    endcase
  end

  assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
