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

    // Define state encoding based on one-hot
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
        // Default values
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;

        case (state)
            S      : begin
                        S_next = !d;
                        S1_next = d;
                     end
            S1     : S_next = !d;
            S11    : begin end
            S110   : S_next = !d;
            B0     : shift_ena = 1;
            B1     : shift_ena = 1;
            B2     : begin
                        shift_ena = 1;
                        B3_next = 1;
                     end
            B3     : begin
                        shift_ena = 1;
                        Count_next = 1;
                     end
            Count  : begin
                        counting = 1;
                        Count_next = !done_counting;
                        Wait_next = done_counting;
                     end
            Wait   : begin
                        done = 1;
                        Wait_next = !ack;
                        S_next = ack;
                     end
            default: begin end
        endcase
    end
endmodule
