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

    // State encoding
    localparam S = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S11 = 10'b0000000100;
    localparam S110 = 10'b0000001000;
    localparam B0 = 10'b0000010000;
    localparam B1 = 10'b0000100000;
    localparam B2 = 10'b0001000000;
    localparam B3 = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait = 10'b1000000000;

    always @(*) begin
        // Reset all outputs
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        // State actions
        case (state)
            S: begin
                if (d == 1'b0) S_next = 1'b1;
                else S1_next = 1'b1;
            end
            
            S1: begin
                if (d == 1'b0) S_next = 1'b1;
            end

            S11, S110: begin
                if (d == 1'b0) S_next = 1'b1;
            end

            B0, B1, B2, B3: begin
                shift_ena = 1'b1;
                if (state == B3) Count_next = 1'b1;
            end

            Count: begin
                counting = 1'b1;
                if (done_counting == 1'b0) Count_next = 1'b1;
                else Wait_next = 1'b1;
            end

            Wait: begin
                if (ack == 1'b1) S_next = 1'b1;
                else Wait_next = 1'b1;
                done = 1'b1;
            end
        endcase

        // Additional output logic
        if (state[B2]) B3_next = 1'b1;
    end

endmodule
