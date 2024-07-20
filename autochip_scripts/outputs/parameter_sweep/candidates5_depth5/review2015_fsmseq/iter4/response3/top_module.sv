module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      start_shifting <= 0;
    end else begin
      state <= next_state;
      start_shifting <= 0; // Reset start_shifting on clock cycles other than reset
    end
  end

  always @* begin
    next_state = state;
    case(state)
      0: begin // Initial state
        if (data) begin
          next_state = 1;
        end else begin
          next_state = 0;
        end
      end
      1: begin // State after receiving 1
        if (data) begin
          next_state = 1;
        end else begin
          next_state = 2;
        end
      end
      2: begin // State after receiving 11
        if (data) begin
          next_state = 3;
        end else begin
          next_state = 0;
        end
      end
      3: begin // State after receiving 110
        if (data) begin
          next_state = 3;
        end else begin
          next_state = 4;
        end
      end
      4: begin // State after receiving 1101
        if (!data) begin
          next_state = 0;
          start_shifting <= 1;
        end else begin
          next_state = 4;
        end
      end
    endcase
  end

endmodule
