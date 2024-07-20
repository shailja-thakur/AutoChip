module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Assign next_state[A]
    always @(*) begin
        if (in == 0)
            next_state[0] = state[0] | state[2]; // A depends on A and C
        else
            next_state[0] = 0;
    end

    // Assign next_state[B]
    always @(*) begin
        if (in == 0)
            next_state[1] = 0; // B depends on A, B, and D
        else
            next_state[1] = state[0] | state[1] | state[3];
    end

    // Assign next_state[C]
    always @(*) begin
        if (in == 0)
            next_state[2] = state[1] | state[3]; // C depends on B and D
        else
            next_state[2] = 0;
    end

    // Assign next_state[D]
    always @(*) begin
        if (in == 1)
            next_state[3] = state[2]; // D depends on C
        else
            next_state[3] = 0;
    end

    // Assign out
    assign out = state[3]; // out depends on D

endmodule
