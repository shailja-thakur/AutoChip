module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output out1,
    output out2);

    // out1 is equal to state[8] or state[9]
    assign out1 = state[8] | state[9];

    // out2 is equal to state[7] or state[9]
    assign out2 = state[7] | state[9];

    // next_state[0] is equal to not(in) and (the or of state[4:0], state[7], state[8], state[9])
    always @(*) begin
        next_state[0] = ~in & (|{state[4:0], state[7], state[8], state[9]});
    end

    // next_state[1] is equal to in and the or of state[0], state[8] and state[9]
    always @(*) begin
        next_state[1] = in & (state[0] | state[8] | state[9]);
    end

    // next_state[2] is equal to in and state[1]
    always @(*) begin
        next_state[2] = in & state[1];
    end

    // next_state[3] is equal to in and state[2]
    always @(*) begin
        next_state[3] = in & state[2];
    end

    // next_state[4] is equal to in and state[3]
    always @(*) begin
        next_state[4] = in & state[3];
    end

    // next_state[5] is equal to in and state[4]
    always @(*) begin
        next_state[5] = in & state[4];
    end

    // next_state[6] is equal to in and state[5]
    always @(*) begin
        next_state[6] = in & state[5];
    end

    // next_state[7] is equal to in and the or of state[6] and state[7]
    always @(*) begin
        next_state[7] = in & (state[6] | state[7]);
    end

    // next_state[8] is equal to not(in) and state[5]
    always @(*) begin
        next_state[8] = ~in & state[5];
    end

    // next_state[9] is equal to not(in) and state[6]
    always @(*) begin
        next_state[9] = ~in & state[6];
    end

endmodule
