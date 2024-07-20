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
  assign B3_next = 0;
  assign S_next = 0;
  assign S1_next = 0;
  assign Count_next = 0;
  assign Wait_next = 0;
  assign done = 0;
  assign counting = 0;
  assign shift_ena = 0;
  
  // State machine logic
  always @(state) begin
    case(state)
      S: begin
        if (d == 0)
          S_next = 1;
      end
      S1: begin
        if (d == 0)
          S1_next = 1;
      end
      S110: begin
        if (d == 0)
          S_next = 1;
      end
      Wait: begin
        if (ack == 1)
          Wait_next = 1;
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
  always @(posedge clk) begin
    case(state)
      Count: begin
        counting = 1;
      end
      Wait: begin
        done = 1;
      end
    endcase
  end

endmodule
