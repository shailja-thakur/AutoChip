module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    // Calculate out1
    wire out1_a = state[8] | state[9];
    assign out1 = out1_a;
    
    // Calculate out2
    wire out2_a = state[7] | state[9];
    assign out2 = out2_a;
    
    // Calculate next_state[0]
    wire next_state_0_a = ~in & (state[4:0] | state[7] | state[8] | state[9]);
    assign next_state[0] = next_state_0_a;
    
    // Calculate next_state[1]
    wire next_state_1_a = in & (state[0] | state[8] | state[9]);
    assign next_state[1] = next_state_1_a;
    
    // Calculate next_state[2]
    wire next_state_2_a = in & state[1];
    assign next_state[2] = next_state_2_a;
    
    // Calculate next_state[3]
    wire next_state_3_a = in & state[2];
    assign next_state[3] = next_state_3_a;
    
    // Calculate next_state[4]
    wire next_state_4_a = in & state[3];
    assign next_state[4] = next_state_4_a;
    
    // Calculate next_state[5]
    wire next_state_5_a = in & state[4];
    assign next_state[5] = next_state_5_a;
    
    // Calculate next_state[6]
    wire next_state_6_a = in & state[5];
    assign next_state[6] = next_state_6_a;
    
    // Calculate next_state[7]
    wire next_state_7_a = in & (state[6] | state[7]);
    assign next_state[7] = next_state_7_a;
    
    // Calculate next_state[8]
    wire next_state_8_a = ~in & state[5];
    assign next_state[8] = next_state_8_a;
    
    // Calculate next_state[9]
    wire next_state_9_a = ~in & state[6];
    assign next_state[9] = next_state_9_a;

endmodule
