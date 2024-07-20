module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;
  wire shift_enable;

  // Create a synchronous reset
  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      start_shifting <= 0;
    end else begin
      state <= next_state;
    end
  end

  always @* begin
    // The shift enable signal is set to 1 when the sequence 1101 is detected
    shift_enable = (state == 4);

    // Determine the next state based on the current state and input data
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
        end else begin
          next_state = 4;
        end
      end
    endcase
  end

  // Set the start_shifting output when shift_enable is high
  always @(posedge clk) begin
    if (reset) begin
      start_shifting <= 0;
    end else begin
      if (shift_enable) begin
        start_shifting <= 1;
      end else begin
        start_shifting <= 0;
      end
    end
  end

endmodule
