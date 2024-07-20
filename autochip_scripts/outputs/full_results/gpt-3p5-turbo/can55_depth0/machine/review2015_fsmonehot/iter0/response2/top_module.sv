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

reg B3_next;
reg S_next;
reg S1_next;
reg Count_next;
reg Wait_next;
reg done;
reg counting;
reg shift_ena;

always @(*) begin
    B3_next = (state[B3] == 1'b1);
    S_next = ((state[S] == 1'b1 && d == 1'b0) || 
              (state[S1] == 1'b1 && d == 1'b0) ||
              (state[S110] == 1'b1 && d == 1'b0) ||
              (state[Wait] == 1'b1 && ack == 1'b1));
    S1_next = (state[S] == 1'b1 && d == 1'b1);
    Count_next = (state[B3] == 1'b1 || 
                  (state[Count] == 1'b1 && done_counting == 1'b0));
    Wait_next = ((state[Count] == 1'b1 && done_counting == 1'b1) || 
                 (state[Wait] == 1'b1 && ack == 1'b0));

    done = (state[Wait] == 1'b1);
    counting = (state[Count] == 1'b1);
    shift_ena = (state[B3] == 1'b1 || 
                 state[B2] == 1'b1 || 
                 state[B1] == 1'b1 || 
                 state[B0] == 1'b1);
end

endmodule
