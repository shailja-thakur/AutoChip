module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  reg [2:0] state; // 3-bit state register
  reg disc_out, flag_out, err_out; // Output registers
  wire in_5; // Wire to check if there are 5 consecutive 1s
  wire in_7; // Wire to check if there are 7 or more consecutive 1s

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b001; // Reset state
      disc_out <= 1'b0;
      flag_out <= 1'b0;
      err_out <= 1'b0;
    end else begin
      case (state)
        3'b001: // State 1: Looking for '0'
          begin
            if (in) begin
              state <= 3'b010; // Transition to state 2
            end else begin
              state <= 3'b001; // Remain in state 1
            end
          end
        3'b010: // State 2: Looking for '1'
          begin
            if (in) begin
              state <= 3'b011; // Transition to state 3
            end else begin
              state <= 3'b001; // Return to state 1
            end
          end
        3'b011: // State 3: Depending on input, transition to appropriate state
          begin
            if (in) begin
              state <= 3'b100; // Transition to state 4
            end else begin
              state <= 3'b001; // Return to state 1
            end
          end
        3'b100: // State 4: Determine output signals and next state
          begin
            if (in) begin
              if (in_5) begin
                disc_out <= 1'b1;
                flag_out <= 1'b0;
                err_out <= 1'b0;
                state <= 3'b101; // Transition to state 5
              end else if (in_7) begin
                disc_out <= 1'b0;
                flag_out <= 1'b0;
                err_out <= 1'b1;
                state <= 3'b001; // Return to state 1
              end else begin
                disc_out <= 1'b0;
                flag_out <= 1'b1;
                err_out <= 1'b0;
                state <= 3'b001; // Return to state 1
              end
            end else begin
              disc_out <= 1'b0;
              flag_out <= 1'b0;
              err_out <= 1'b0;
              state <= 3'b001; // Return to state 1
            end
          end
        3'b101: // State 5: Looking for '0' after 5 consecutive 1s
          begin
            if (in) begin
              state <= 3'b101; // Remain in state 5
            end else begin
              state <= 3'b001; // Return to state 1
            end
          end
      endcase
    end
  end

  // Check if there are 5 or more consecutive 1s
  assign in_5 = (in && state == 3'b100) ? 1'b1 : 1'b0;
  assign in_7 = (in && state == 3'b101) ? 1'b1 : 1'b0;

  // Assign output signals
  assign disc = disc_out;
  assign flag = flag_out;
  assign err = err_out;

endmodule
