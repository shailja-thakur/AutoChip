module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [2:0] state;
  reg done_next;
  wire [3:0] in3;

  assign in3 = {1'b0, in[3]};

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      done_next <= 0;
    end else begin
      case(state)
        0: begin // Idle state
          if (in3) begin
            state <= 1;
          end
        end
        1: begin // First byte received
          state <= 2;
        end
        2: begin // Second byte received
          state <= 3;
        end
        3: begin // Third byte received
          state <= 0;
          done_next <= 1;
        end
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      done <= 0;
    end else begin
      done <= done_next;
    end
  end

endmodule
