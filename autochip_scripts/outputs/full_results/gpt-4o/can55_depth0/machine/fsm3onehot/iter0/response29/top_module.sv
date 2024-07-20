module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Assign statements for next_state ports
    always @* begin
        if (in == 0) begin
            next_state[0] = state[0] | state[2]; // next_state[A]
        end else begin
            next_state[0] = 0;
        end

        if (in == 0) begin
            next_state[1] = 0; // next_state[B]
        end else begin
            next_state[1] = state[0] | state[1] | state[3];
        end

        if (in == 0) begin
            next_state[2] = state[1] | state[3]; // next_state[C]
        end else begin
            next_state[2] = 0;
        end

        if (in == 0) begin
            next_state[3] = 0; // next_state[D]
        end else begin
            next_state[3] = state[2];
        end
    end

    // Assign statement for out port
    assign out = state[3]; // out depends on state[D]

endmodule
