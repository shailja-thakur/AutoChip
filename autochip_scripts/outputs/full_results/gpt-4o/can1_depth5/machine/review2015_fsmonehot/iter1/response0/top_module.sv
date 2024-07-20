module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output done,
    output counting,
    output shift_ena
 );
    
    // State encoding
    localparam S      = 0,
               S1     = 1,
               S11    = 2,
               S110   = 3,
               B0     = 4,
               B1     = 5,
               B2     = 6,
               B3     = 7,
               COUNT  = 8,
               WAIT   = 9;

    // Assign output based on the current state
    always @(*) begin
        // Default values for all outputs
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        
        if (state[B2]) B3_next = 1;
        if ((state[S] & ~d) | (state[S1] & ~d) | (state[S110] & ~d) | (state[WAIT] & ack)) S_next = 1;
        if (state[S] & d) S1_next = 1;
        if ((state[B3]) | (state[COUNT] & ~done_counting)) Count_next = 1;
        if ((state[COUNT] & done_counting) | (state[WAIT] & ~ack)) Wait_next = 1;
    end

    assign done = state[WAIT];
    assign counting = state[COUNT];
    assign shift_ena = state[B0] | state[B1] | state[B2] | state[B3];

endmodule
