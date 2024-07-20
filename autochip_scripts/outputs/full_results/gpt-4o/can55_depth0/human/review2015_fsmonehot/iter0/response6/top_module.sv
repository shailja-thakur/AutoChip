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

    // State assignment using one-hot encoding
    parameter S    = 10'b0000000001;
    parameter S1   = 10'b0000000010;
    parameter S11  = 10'b0000000100;
    parameter S110 = 10'b0000001000;
    parameter B0   = 10'b0000010000;
    parameter B1   = 10'b0000100000;
    parameter B2   = 10'b0001000000;
    parameter B3   = 10'b0010000000;
    parameter Count = 10'b0100000000;
    parameter Wait = 10'b1000000000;

    // Outputs are set based on states
    assign shift_ena = state[B0] | state[B1] | state[B2] | state[B3];
    assign counting = state[Count];
    assign done = state[Wait];

    // Next state logic
    assign S_next = state[S] & d & ~state[S1];
    assign S1_next = (state[S] & d) | (state[S1] & ~d);
    assign S11_next = state[S1] & d;
    assign S110_next = state[S11] & ~d;
    assign B0_next = (state[S110] & d) | (state[B3]);
    assign B1_next = state[B0];
    assign B2_next = state[B1];
    assign B3_next = state[B2];
    assign Count_next = (state[B3] & ~done_counting) | (state[Count] & ~done_counting);
    assign Wait_next = (state[Count] & done_counting) | (state[Wait] & ~ack);
    assign Done_next = state[Wait] & ack;

    // Combinational logic for next state transitions
    always @(*) begin
        case (state)
            S: begin
                if (d) next_state = S1;
                else next_state = S;
            end
            S1: begin
                if (d) next_state = S11;
                else next_state = S;
            end
            S11: begin
                if (d) next_state = S11;
                else next_state = S110;
            end
            S110: begin
                if (d) next_state = B0;
                else next_state = S;
            end
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Count;
            Count: begin
                if (done_counting) next_state = Wait;
                else next_state = Count;
            end
            Wait: begin
                if (ack) next_state = S;
                else next_state = Wait;
            end
            default: next_state = S;
        endcase
    end
endmodule
