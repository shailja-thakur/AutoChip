module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Assign statement for next_state[A]
    always @(*) begin
        if (in == 1'b0) begin
            next_state[0] = state[0] | state[2]; // OR'ed value of state[A] and state[C]
        end else begin
            next_state[0] = 1'b0;
        end
    end

    // Assign statement for next_state[B]
    always @(*) begin
        if (in == 1'b0) begin
            next_state[1] = 1'b0;
        end else begin
            next_state[1] = state[0] | state[1] | state[3]; // OR'ed value of state[A], state[B], and state[D]
        end
    end

    // Assign statement for next_state[C]
    always @(*) begin
        if (in == 1'b0) begin
            next_state[2] = state[1] | state[3]; // OR'ed value of state[B] and state[D]
        end else begin
            next_state[2] = 1'b0;
        end
    end

    // Assign statement for next_state[D]
    always @(*) begin
        if (in == 1'b0) begin
            next_state[3] = 1'b0;
        end else begin
            next_state[3] = state[2]; // state[C]
        end
    end

    // Assign statement for out
    assign out = state[3]; // Assigned to the value of state[D]

endmodule
