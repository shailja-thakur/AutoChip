module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Assign next_state[A]
    always @(*) begin
        if (in == 1'b0) begin
            next_state[0] = state[0] | state[2];
        end else begin
            next_state[0] = 0;
        end
    end

    // Assign next_state[B]
    always @(*) begin
        if (in == 1'b0) begin
            next_state[1] = 0;
        end else begin
            next_state[1] = state[0] | state[1] | state[3];
        end
    end

    // Assign next_state[C]
    always @(*) begin
        if (in == 1'b0) begin
            next_state[2] = state[1] | state[3];
        end else begin
            next_state[2] = 0;
        end
    end

    // Assign next_state[D]
    always @(*) begin
        if (in == 1'b0) begin
            next_state[3] = 0;
        end else begin
            next_state[3] = state[2];
        end
    end

    // Assign out
    assign out = state[3];

endmodule
