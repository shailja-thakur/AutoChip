module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);
    // State definitions
    localparam S = 9'b0000000001;
    localparam S1 = 9'b0000000010;
    localparam S11 = 9'b0000000100;
    localparam S110 = 9'b0000001000;
    localparam B0 = 9'b0000010000;
    localparam B1 = 9'b0000100000;
    localparam B2 = 9'b0001000000;
    localparam B3 = 9'b0010000000;
    localparam Count = 9'b0100000000;
    localparam Wait = 9'b1000000000;

    // Next-State Logic
    assign S_next = ((state[S] & ~d) || 
                     (state[S1] & ~d) || 
                     (state[S110] & ~d) || 
                     (state[Wait] & ack));

    assign S1_next = state[S] & d;

    wire S11_next = (state[S1] & d) | (state[S11] & d);
    wire S110_next = (state[S11] & ~d);
    
    wire B0_next = state[S110] & d;
    wire B1_next = state[B0];
    wire B2_next = state[B1];
    assign B3_next = state[B2];
    
    assign Count_next = state[B3];
    
    assign Wait_next = (state[Count] & done_counting) | 
                       (state[Wait] & ~ack);

    // Output logic
    assign done = state[Wait];
    assign counting = state[Count];
    assign shift_ena = state[B0] | 
                       state[B1] | 
                       state[B2] | 
                       state[B3];
endmodule
