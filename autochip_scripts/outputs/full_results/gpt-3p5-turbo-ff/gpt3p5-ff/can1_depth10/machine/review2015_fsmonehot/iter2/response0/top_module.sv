module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );
 
  // Define the states
  parameter S = 10'b0000000001;
  parameter S1 = 10'b0000000010;
  parameter S11 = 10'b0000000100;
  parameter S110 = 10'b0000001000;
  parameter B0 = 10'b0000010000;
  parameter B1 = 10'b0000100000;
  parameter B2 = 10'b0001000000;
  parameter B3 = 10'b0010000000;
  parameter Count = 10'b0100000000;
  parameter Wait = 10'b1000000000;

  // Assign default values to the outputs
  always @(state) begin
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;
  end
  
  // State machine logic
  always @(state, d, ack) begin
    case(state)
      S: begin
        if (d == 0)
          S_next = 1;
        else
          S_next = 0;
      end
      S1: begin
        if (d == 0)
          S1_next = 1;
        else
          S1_next = 0;
      end
      S110: begin
        if (d == 0)
          S_next = 1;
        else
          S_next = 0;
      end
      Wait: begin
        if (ack == 1)
          Wait_next = 1;
        else
          Wait_next = 0;
      end
      Count: begin
        if (done_counting == 0)
          Count_next = 1;
        else
          Wait_next = 1;
      end
      B2: begin
        B3_next = 1;
      end
      B3: begin
        Count_next = 1;
        shift_ena = 1;
      end
    endcase
  end

  // Output logic
  always @(state) begin
    case(state)
      Count: begin
        counting = 1;
        done = 0;
      end
      Wait: begin
        done = 1;
        counting = 0;
      end
      default: begin
        done = 0;
        counting = 0;
      end
    endcase
  end

endmodule
