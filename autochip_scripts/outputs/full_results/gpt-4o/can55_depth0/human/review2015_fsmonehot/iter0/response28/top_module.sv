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
    
    // Next state logic
    always @(*) begin
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;

        case (state)
            S: begin
                S_next = (d == 0);
                S1_next = (d == 1);
            end
            S1: begin
                S_next = (d == 0);
                S1_next = (d == 1);
            end
            S11: begin
                S_next = (d == 0);
                S110_next = (d == 1);
            end
            S110: begin
                S_next = (d == 0);
                B0_next = (d == 1);
            end
            B0: begin
                B1_next = 1;
                shift_ena = 1;
            end
            B1: begin
                B2_next = 1;
                shift_ena = 1;
            end
            B2: begin
                B3_next = 1;
                shift_ena = 1;
            end
            B3: begin
                Count_next = 1;
                shift_ena = 1;
            end
            Count: begin
                if (!done_counting)
                    Count_next = 1;
                else
                    Wait_next = 1;
                counting = 1;
            end
            Wait: begin
                if (ack)
                    S_next = 1;
                else
                    Wait_next = 1;
                done = 1;
            end
            default: begin
                S_next = 1;  // default state is S
            end
        endcase
    end

endmodule
