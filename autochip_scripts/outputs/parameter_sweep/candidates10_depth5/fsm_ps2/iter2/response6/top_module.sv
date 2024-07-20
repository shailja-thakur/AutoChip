module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg prev_in3;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
    prev_in3 <= 0;
  end else begin
    prev_in3 <= in[3];

    case (state)
      0: begin  // Idle state
        if (in[3] == 1 && prev_in3 == 0) begin
          state <= 1;  // Transition to first byte state
        end
      end
      1: begin  // First byte state
        state <= 2;
      end
      2: begin  // Second byte state
        state <= 3;
      end
      3: begin  // Third byte state
	 if (in[3] == 1 && prev_in3 == 1) begin
          state <= 0;  // Transition back to idle state
      	end
      end
    endcase
  end
end

assign done = (state == 3);

endmodule
