module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Assign values to the next_state[A] port
    always @(*) begin
        if (in == 1'b0)
            next_state[0] = state[0] | state[2];
        else
            next_state[0] = 1'b0;
    end

    // Assign values to the next_state[B] port
    always @(*) begin
        if (in == 1'b0)
            next_state[1] = 1'b0;
        else
            next_state[1] = state[0] | state[1] | state[3];
    end

    // Assign values to the next_state[C] port
    always @(*) begin
        if (in == 1'b0)
            next_state[2] = state[1] | state[3];
        else
            next_state[2] = 1'b0;
    end

    // Assign values to the next_state[D] port
    always @(*) begin
        if (in == 1'b0)
            next_state[3] = 1'b0;
        else
            next_state[3] = state[2];
    end

    // Assign value to the out port
    assign out = state[3];

endmodule
