module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);
  reg state, next_state;

  // synchronous reset
  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
    end else begin
      state <= next_state;
    end
  end

  // next state logic
  always @(state, j, k) begin
    case (state)
      0: begin // state A
        if (j) begin
          next_state <= 1; // state B
        end else begin
          next_state <= 0; // state A
        end
      end
      1: begin // state B
        if (k) begin
          next_state <= 0; // state A
        end else begin
          next_state <= 1; // state B
        end
      end
    endcase
  end

  // output logic
  always @(state) begin
    if (state) begin
      out <= 1; // state B
    end else begin
      out <= 0; // state A
    end
  end
endmodule
