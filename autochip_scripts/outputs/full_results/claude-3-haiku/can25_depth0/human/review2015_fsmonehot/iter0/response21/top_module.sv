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

always @(*) begin
    // Default values
    B3_next = 1'b0;
    S_next = 1'b0;
    S1_next = 1'b0;
    Count_next = 1'b0;
    Wait_next = 1'b0;
    done = 1'b0;
    counting = 1'b0;
    shift_ena = 1'b0;

    case (state)
        10'b0000000001: // State S
            if (d == 1'b0) begin
                S_next = 1'b1;
            end else begin
                S1_next = 1'b1;
            end

        10'b0000000010: // State S1
            if (d == 1'b0) begin
                S_next = 1'b1;
            end else begin
                S1_next = 1'b1;
            end

        10'b0000000100: // State S11
            if (d == 1'b0) begin
                S110_next = 1'b1;
            end else begin
                S11_next = 1'b1;
            end

        10'b0000001000: // State S110
            if (d == 1'b0) begin
                S_next = 1'b1;
            end else begin
                B0_next = 1'b1;
            end

        10'b0000010000: // State B0
            B1_next = 1'b1;
            shift_ena = 1'b1;

        10'b0000100000: // State B1
            B2_next = 1'b1;
            shift_ena = 1'b1;

        10'b0001000000: // State B2
            B3_next = 1'b1;
            shift_ena = 1'b1;

        10'b0010000000: // State B3
            Count_next = 1'b1;
            shift_ena = 1'b1;

        10'b0100000000: // State Count
            if (done_counting == 1'b0) begin
                Count_next = 1'b1;
                counting = 1'b1;
            end else begin
                Wait_next = 1'b1;
            end

        10'b1000000000: // State Wait
            if (ack == 1'b0) begin
                Wait_next = 1'b1;
                done = 1'b1;
            end else begin
                S_next = 1'b1;
            end

        default:
            // Do nothing
    endcase
end

endmodule
