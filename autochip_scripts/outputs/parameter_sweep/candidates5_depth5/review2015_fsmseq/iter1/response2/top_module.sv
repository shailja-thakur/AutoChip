module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      start_shifting <= 0;
    end else begin
      state <= next_state;
    end
  end

  always @(state or data) begin
    case (state)
      0: begin // Initial state
        if (data == 1'b1) begin
          next_state = 1;
        end else begin
          next_state = 0;
        end
        start_shifting = 0;
      end
      1: begin // State after receiving 1
        if (data == 1'b1) begin
          next_state = 1;
        end else begin
          next_state = 2;
        end
        start_shifting = 0;
      end
      2: begin // State after receiving 11
        if (data == 1'b1) begin
          next_state = 3;
        end else begin
          next_state = 0;
        end
        start_shifting = 0;
      end
      3: begin // State after receiving 110
        if (data == 1'b1) begin
          next_state = 3;
        end else begin
          next_state = 4;
        end
        start_shifting = 0;
      end
      4: begin // State after receiving 1101
        if (data == 1'b1) begin
          next_state = 3;
        end else begin
          next_state = 4;
          start_shifting = 1;
        end
      end
      default: begin
        next_state = 0;
        start_shifting = 0;
      end
    endcase
  end

endmodule
