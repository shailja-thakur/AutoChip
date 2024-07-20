module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  reg [2:0] state, next_state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      state <= next_state;
    end
  end

  always @(state or in) begin
    case (state)
      3'b000: begin // initial state, behaves as though the previous input were 0
        if (in == 1) begin
          next_state = 3'b100; // move to state for first 1
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end else begin
          next_state = 3'b000; // stay in initial state for 0
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end
      end
      3'b100: begin // state for first 1
        if (in == 1) begin
          next_state = 3'b101; // move to state for second 1
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end else begin
          next_state = 3'b000; // move back to initial state for 0
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end
      end
      3'b101: begin // state for second 1
        if (in == 1) begin
          next_state = 3'b110; // move to state for third 1
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end else begin
          next_state = 3'b000; // move back to initial state for 0
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end
      end
      3'b110: begin // state for third 1
        if (in == 1) begin
          next_state = 3'b111; // move to state for fourth 1
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end else begin
          next_state = 3'b000; // move back to initial state for 0
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end
      end
      3'b111: begin // state for fourth 1
        if (in == 1) begin
          next_state = 3'b100; // move to state for first 1 as fifth 1 is reached
          disc = 1'b1; // assert disc to signal a bit needs to be discarded
          flag = 1'b0;
          err = 1'b0;
        end else begin
          next_state = 3'b001; // move to state for zero after five 1s
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end
      end
      3'b001: begin // state for zero after five 1s
        if (in == 1) begin
          next_state = 3'b111; // move to state for fourth 1 as zero after five 1s is reached
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end else begin
          next_state = 3'b010; // move to state for flag as zero after five 1s and zero is reached
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end
      end
      3'b010: begin // state for flag
        if (in == 1) begin
          next_state = 3'b100; // move to state for first 1 as start/end flag is reached
          disc = 1'b0;
          flag = 1'b1; // assert flag to signal the beginning/end of a frame
          err = 1'b0;
        end else begin
          next_state = 3'b011; // move to state for error as zero after flag is reached
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end
      end
      3'b011: begin // state for error
        if (in == 1) begin
          next_state = 3'b111; // move to state for fourth 1 as error is still present
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b0;
        end else begin
          next_state = 3'b011; // stay in error state for 0
          disc = 1'b0;
          flag = 1'b0;
          err = 1'b1; // assert err to signal an error with seven or more consecutive 1s
        end
      end
    endcase
  end

endmodule
