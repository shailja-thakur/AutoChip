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

    // Define state encoding
    localparam S = 10'b0000000001,
               S1 = 10'b0000000010,
               S11 = 10'b0000000100,
               S110 = 10'b0000001000,
               B0 = 10'b0000010000,
               B1 = 10'b0000100000,
               B2 = 10'b0001000000,
               B3 = 10'b0010000000,
               Count = 10'b0100000000,
               Wait = 10'b1000000000;
               
    always @(*) begin
        // Default assignments
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        // Output logic
        case (state)
            S: begin
                S_next = ~d;
                S1_next = d;
            end
            S1: begin
                S_next = ~d;
            end
            S11: begin
                // No special output, default zero
            end
            S110: begin
                S_next = ~d;
            end
            B0, B1, B2, B3: begin
                shift_ena = 1'b1;
                if (state == B3) begin
                    Count_next = 1'b1;
                end
                if (state == B2) begin
                    B3_next = 1'b1;
                end
            end
            Count: begin
                counting = 1'b1;
                if (done_counting) begin
                    Wait_next = 1'b1;
                end else begin
                    Count_next = 1'b1;
                end
            end
            Wait: begin
                done = 1'b1;
                if (!ack) begin
                    Wait_next = 1'b1;
                end else if (ack) begin
                    S_next = 1'b1;
                end
            end
            default: ; // Do nothing
        endcase
    end
endmodule
