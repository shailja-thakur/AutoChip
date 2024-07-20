module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg prev_in3;

reg done_reg;
wire done_int;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
    prev_in3 <= 0;
    done_reg <= 0;
  end else begin
    prev_in3 <= in[3];

    case (state)
      0: begin  // Idle state
        if (in[3] == 1 && prev_in3 == 0) begin
          state <= 1;  // Transition to first byte state
        end
      end
      1: begin  // First byte state
        state <= 2;  // Transition to second byte state
      end
      2: begin  // Second byte state
        state <= 3;  // Transition to third byte state
      end
      3: begin  // Third byte state
        state <= 0;  // Transition back to idle state
        done_reg <= 1;  // Set done register
      end
    endcase
  end
end

assign done_int = (state == 3);
assign done = done_int;

always @(posedge clk) begin
  if (reset) begin
    done_reg <= 0;
  end else begin
    done_reg <= done_int;
  end
end

endmodule
