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
    output reg done,
    output reg counting,
    output reg shift_ena
);

    // State encoding (one-hot)
    localparam S     = 10'b0000000001;
    localparam S1    = 10'b0000000010;
    localparam S11   = 10'b0000000100;
    localparam S110  = 10'b0000001000;
    localparam B0    = 10'b0000010000;
    localparam B1    = 10'b0000100000;
    localparam B2    = 10'b0001000000;
    localparam B3    = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait  = 10'b1000000000;

    // Combinational logic to determine outputs
    always @(*) begin
        // Default values
        done = 0;
        counting = 0;
        shift_ena = 0;
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;

        // Ensure only one-hot states are valid
        if (state == S || state == S1 || state == S11 || state == S110 || 
            state == B0 || state == B1 || state == B2 || state == B3 || 
            state == Count || state == Wait) begin

            // Outputs based on states
            done = (state == Wait);
            counting = (state == Count);
            shift_ena = (state == B3) | (state == B2) | (state == B1) | (state == B0);

            // Next state logic
            B3_next = (state == B2);
            S_next = (state == S && !d) | (state == S1 && !d) | (state == S110 && !d) | (state == Wait && ack);
            S1_next = (state == S && d);
            Count_next = (state == B3) | (state == Count && !done_counting);
            Wait_next = (state == Count && done_counting) | (state == Wait && !ack);
        end
    end

endmodule
