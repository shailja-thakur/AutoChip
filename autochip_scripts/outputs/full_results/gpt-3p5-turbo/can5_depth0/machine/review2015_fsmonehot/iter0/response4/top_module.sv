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

    reg B3;
    reg S, S1, S11, S110;
    reg B0, B1, B2;
    reg Count, Wait;

    assign done = (state == 10'h7);
    assign counting = (state == 10'h8);
    assign shift_ena = (B3 || B2 || B1 || B0);

    always @(state) begin
        B3_next = (state == 10'h6);
        S_next = ((state == 10'h0 && !d) || (state == 10'h1 && !d) || (state == 10'h3 && !d) || (state == 10'h7 && ack));
        S1_next = (state == 10'h0 && d);
        Count_next = (state == 10'h6 || (state == 10'h8 && !done_counting));
        Wait_next = ((state == 10'h8 && done_counting) || (state == 10'h7 && !ack));
    end

    always @(posedge clock) begin
        case (state)
            10'h0: begin
                S = 1;
                S1 = 0;
                S11 = 0;
                S110 = 0;
                B0 = 0;
                B1 = 0;
                B2 = 0;
                B3 = 0;
                Count = 0;
                Wait = 0;
            end

            10'h1: begin
                S = 0;
                S1 = 1;
                S11 = 0;
                S110 = 0;
                B0 = 0;
                B1 = 0;
                B2 = 0;
                B3 = 0;
                Count = 0;
                Wait = 0;
            end

            10'h2: begin
                S = 0;
                S1 = 0;
                S11 = 1;
                S110 = 0;
                B0 = 0;
                B1 = 0;
                B2 = 0;
                B3 = 0;
                Count = 0;
                Wait = 0;
            end

            10'h3: begin
                S = 0;
                S1 = 0;
                S11 = 0;
                S110 = 1;
                B0 = 0;
                B1 = 0;
                B2 = 0;
                B3 = 0;
                Count = 0;
                Wait = 0;
            end

            10'h4: begin
                S = 0;
                S1 = 0;
                S11 = 0;
                S110 = 0;
                B0 = 1;
                B1 = 0;
                B2 = 0;
                B3 = 0;
                Count = 0;
                Wait = 0;
            end

            10'h5: begin
                S = 0;
                S1 = 0;
                S11 = 0;
                S110 = 0;
                B0 = 0;
                B1 = 1;
                B2 = 0;
                B3 = 0;
                Count = 0;
                Wait = 0;
            end

            10'h6: begin
                S = 0;
                S1 = 0;
                S11 = 0;
                S110 = 0;
                B0 = 0;
                B1 = 0;
                B2 = 1;
                B3 = 0;
                Count = 0;
                Wait = 0;
            end

            10'h7: begin
                S = 0;
                S1 = 0;
                S11 = 0;
                S110 = 0;
                B0 = 0;
                B1 = 0;
                B2 = 0;
                B3 = 1;
                Count = 0;
                Wait = 0;
            end

            10'h8: begin
                S = 0;
                S1 = 0;
                S11 = 0;
                S110 = 0;
                B0 = 0;
                B1 = 0;
                B2 = 0;
                B3 = 0;
                Count = 1;
                Wait = 0;
            end

            10'h9: begin
                S = 0;
                S1 = 0;
                S11 = 0;
                S110 = 0;
                B0 = 0;
                B1 = 0;
                B2 = 0;
                B3 = 0;
                Count = 0;
                Wait = 1;
            end

            default: begin
                S = 0;
                S1 = 0;
                S11 = 0;
                S110 = 0;
                B0 = 0;
                B1 = 0;
                B2 = 0;
                B3 = 0;
                Count = 0;
                Wait = 0;
            end
        endcase
    end

endmodule
