module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2
);

    reg [9:0] temp_next_state;

    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];
    
    always @(*) begin
        temp_next_state[0] = ~in & (|state[4:0], state[7], state[8], state[9]);
        temp_next_state[1] = in & (state[0] | state[8] | state[9]);
        temp_next_state[2] = in & state[1];
        temp_next_state[3] = in & state[2];
        temp_next_state[4] = in & state[3];
        temp_next_state[5] = in & state[4];
        temp_next_state[6] = in & state[5];
        temp_next_state[7] = in & (state[6] | state[7]);
        temp_next_state[8] = ~in & state[5];
        temp_next_state[9] = ~in & state[6];
    end
    
    assign next_state = temp_next_state;
    
endmodule
