module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;
  wire reset_sync;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      start_shifting <= 0;
    end else begin
      state <= next_state;
    end
  end

  // Synchronous reset
  always @(posedge clk) begin
    reset_sync <= reset;
  end

  always @(state, data) begin
    case(state)
      0: begin // Initial state
        if (reset_sync) begin
          next_state = 0;
        end else if (data) begin
          next_state = 1;
        end else begin
          next_state = 0;
        end
      end
      1: begin // State after receiving 1
        if (reset_sync) begin
          next_state = 0;
        end else if (data) begin
          next_state = 1;
        end else begin
          next_state = 2;
        end
      end
      2: begin // State after receiving 11
        if (reset_sync) begin
          next_state = 0;
        end else if (data) begin
          next_state = 3;
        end else begin
          next_state = 0;
        end
      end
      3: begin // State after receiving 110
        if (reset_sync) begin
          next_state = 0;
        end else if (data) begin
          next_state = 3;
        end else begin
          next_state = 4;
        end
      end
      4: begin // State after receiving 1101
        if (reset_sync) begin
          next_state = 0;
        end else if (!data) begin
          next_state = 0;
          start_shifting <= 1;
        end else begin
          next_state = 4;
        end
      end
    endcase
  end

endmodule
