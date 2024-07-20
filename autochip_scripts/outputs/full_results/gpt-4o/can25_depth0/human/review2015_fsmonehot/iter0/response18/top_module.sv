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
    parameter S     = 10'b0000000001;
    parameter S1    = 10'b0000000010;
    parameter S11   = 10'b0000000100;
    parameter S110  = 10'b0000001000;
    parameter B0    = 10'b0000010000;
    parameter B1    = 10'b0000100000;
    parameter B2    = 10'b0001000000;
    parameter B3    = 10'b0010000000;
    parameter Count = 10'b0100000000;
    parameter Wait  = 10'b1000000000;

    // Next state logic
    always @(*) begin
        // Default values
        S_next = 0;
        S1_next = 0;
        B3_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;

        case (state)
            S: begin
                S_next = ~d;
                S1_next = d;
            end
            S1: begin
                S_next = ~d;
                B3_next = d;
            end
            S11: begin
                S_next = ~d;
                B3_next = d;
            end
            S110: begin
                S_next = ~d;
                B0_next = d;
            end
            B0: begin
                shift_ena = 1;
                B1_next = 1;
            end
            B1: begin
                shift_ena = 1;
                B2_next = 1;
            end
            B2: begin
                shift_ena = 1;
                B3_next = 1;
            end
            B3: begin
                shift_ena = 1;
                Count_next = 1;
            end
            Count: begin
                counting = 1;
                Count_next = ~done_counting;
                Wait_next = done_counting;
            end
            Wait: begin
                done = 1;
                S_next = ack;
                Wait_next = ~ack;
            end
        endcase
    end

endmodule
