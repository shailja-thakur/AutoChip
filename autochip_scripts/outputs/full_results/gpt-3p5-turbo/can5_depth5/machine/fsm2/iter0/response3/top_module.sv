module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

  parameter A = 1'b0;
  parameter B = 1'b1;
  reg state, next_state;

  always_comb begin
    case (state)
      A: begin
        if (j) begin
          next_state = B;
        end
        else begin
          next_state = A;
        end
      end
      B: begin
        if (k) begin
          next_state = A;
        end
        else begin
          next_state = B;
        end
      end
    endcase
  end

  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= A;
    end
    else begin
      state <= next_state;
    end
  end

  assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
