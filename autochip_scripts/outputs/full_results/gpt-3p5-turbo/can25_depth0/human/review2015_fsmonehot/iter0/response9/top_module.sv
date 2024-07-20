module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

  wire S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;

  assign shift_ena = (state == 10'b1000000000) ? 1'b1 : 1'b0;
  assign counting = (state == Count) ? 1'b1 : 1'b0;
  assign done = (state == Wait) ? 1'b1 : 1'b0;

  assign S_next = (state == S) ? (d == 1'b0) ? 1'b1 : 1'b0 : 1'b0;
  assign S1_next = (state == S1) ? (d == 1'b0) ? 1'b1 : 1'b0 : (d == 1'b1) ? 1'b1 : 1'b0;
  assign Count_next = (state == Count) ? (done_counting == 1'b0) ? 1'b1 : 1'b0 : (done_counting == 1'b1) ? 1'b1 : 1'b0;
  assign Wait_next = (state == Wait) ? (ack == 1'b0) ? 1'b1 : 1'b0 : (ack == 1'b1) ? 1'b1 : 1'b0;
  assign B3_next = state == B3 ? 1'b1 : 1'b0;

  // Internal state machines
  always @(posedge clk) begin
    if (S_next) state <= 10'b0000000001;
    else if (S1_next) state <= 10'b0000000010;
    else if (Count_next) state <= 10'b0000001000;
    else if (Wait_next) state <= 10'b0000010000;
    else if (B3_next) state <= 10'b1000000000;
    else state <= state;
  end


endmodule
