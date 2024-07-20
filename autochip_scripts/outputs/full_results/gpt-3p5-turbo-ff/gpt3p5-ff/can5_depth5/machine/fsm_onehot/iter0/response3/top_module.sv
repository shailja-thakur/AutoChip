module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    wire out1_wire, out2_wire;

    assign out1_wire = state[8] | state[9];
    assign out2_wire = state[7] | state[9];

    assign out1 = out1_wire;
    assign out2 = out2_wire;

    assign next_state[0] = ~in & (state[4:0] | state[7] | state[8] | state[9]);
    assign next_state[1] = in & (state[0] | state[8] | state[9]);
    assign next_state[2] = in & state[1];
    assign next_state[3] = in & state[2];
    assign next_state[4] = in & state[3];
    assign next_state[5] = in & state[4];
    assign next_state[6] = in & state[5];
    assign next_state[7] = in & (state[6] | state[7]);
    assign next_state[8] = ~in & state[5];
    assign next_state[9] = ~in & state[6];

endmodule
