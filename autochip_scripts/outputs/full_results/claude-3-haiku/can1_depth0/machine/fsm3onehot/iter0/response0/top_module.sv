module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    always @(*) begin
        // Assign values to the next_state ports
        next_state[0] = (in) ? 1'b0 : (state[0] | state[2]);
        next_state[1] = (in) ? (state[0] | state[1] | state[3]) : 1'b0;
        next_state[2] = (in) ? 1'b0 : (state[1] | state[3]);
        next_state[3] = (in) ? state[2] : 1'b0;

        // Assign value to the out port
        out = state[3];
    end

endmodule
