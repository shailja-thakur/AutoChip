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
    localparam S      = 10'b0000000001;
    localparam S1     = 10'b0000000010;
    localparam S11    = 10'b0000000100;
    localparam S110   = 10'b0000001000;
    localparam B0     = 10'b0000010000;
    localparam B1     = 10'b0000100000;
    localparam B2     = 10'b0001000000;
    localparam B3     = 10'b0010000000;
    localparam COUNT  = 10'b0100000000;
    localparam WAIT   = 10'b1000000000;

    // Assign output based on the current state
    always @(*) begin
        // Default values for all outputs
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        
        case (1'b1)
            state[S2]: B3_next = 1;
            state[S0] & ~d: S_next = 1;
            state[S1] & ~d: S_next = 1;
            state[S110] & ~d: S_next = 1;
            state[WAIT] & ack: S_next = 1;
            state[S0] & d: S1_next = 1;
            state[S3] & ~done_counting: Count_next = 1;
            state[COUNT] & ~done_counting: Count_next = 1;
            state[COUNT] & done_counting: Wait_next = 1;
            state[WAIT] & ~ack: Wait_next = 1;
        endcase
    end

    assign done = state[WAIT];
    assign counting = state[COUNT];
    assign shift_ena = state[B0] | state[B1] | state[B2] | state[B3];

endmodule
