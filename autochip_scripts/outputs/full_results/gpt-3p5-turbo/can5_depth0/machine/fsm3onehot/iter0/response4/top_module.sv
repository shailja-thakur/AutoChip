module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Assign next_state[A]
    always @(state[A], state[C], in)
    begin
        if (in == 1'b0)
            next_state[A] = state[A] | state[C];
        else
            next_state[A] = 4'b0;
    end

    // Assign next_state[B]
    always @(state[A], state[B], state[D], in)
    begin
        if (in == 1'b0)
            next_state[B] = 4'b0;
        else
            next_state[B] = state[A] | state[B] | state[D];
    end

    // Assign next_state[C]
    always @(state[B], state[D], in)
    begin
        if (in == 1'b0)
            next_state[C] = state[B] | state[D];
        else
            next_state[C] = 4'b0;
    end

    // Assign next_state[D]
    always @(state[C], in)
    begin
        if (in == 1'b0)
            next_state[D] = 4'b0;
        else
            next_state[D] = state[C];
    end

    // Assign out
    assign out = state[D];

endmodule
