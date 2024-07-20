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
    reg [9:0] next_state;

    always @(state, d) begin
        case(state)
            // S case
            10'b0000000001: begin
                S_next = (d == 0);
                S1_next = 0;
                Count_next = 0;
                Wait_next = ((state == 10'b0000000001) & ack);
                B3_next = 0;
                done = 0;
                counting = 0;
                shift_ena = ((state == 10'b0000000100) | (state == 10'b0000000010) | (state == 10'b0000000001) | (state == 10'b0000000000) & (state != 10'b0000000001));
            end
            // S1 case
            10'b0000000010: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                Count_next = 0;
                Wait_next = ((state == 10'b0000000001) & ack);
                B3_next = 0;
                done = 0;
                counting = 0;
                shift_ena = ((state == 10'b0000000100) | (state == 10'b0000000010) | (state  == 10'b0000000001) | (state == 10'b0000000000) & (state != 10'b0000000001));
            end
            // S110 case
            10'b0000000100: begin
                S_next = (d == 0);
                S1_next = 0;
                Count_next = 0;
                Wait_next = ((state == 10'b0000000001) & ack);
                B3_next = 0;
                done = 0;
                counting = 0;
                shift_ena = ((state == 10'b0000000100) | (state == 10'b0000000010) | (state  == 10'b0000000001) | (state == 10'b0000000000) & (state != 10'b0000000001));
            end
            // Wait case
            10'b0000001000: begin
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ((state == 10'b0000000001) & ack);
                B3_next = 0;
                done = 1;
                counting = 0;
                shift_ena = ((state == 10'b0000000100) | (state == 10'b0000000010) | (state  == 10'b0000000001) | (state == 10'b0000000000) & (state != 10'b0000000001));
            end
            default: begin
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ((state == 10'b0000000001) & ack);
                B3_next = ((state == 10'b0000000010));
                done = 0;
                counting = 0;
                shift_ena = ((state == 10'b0000000100) | (state == 10'b0000000010) | (state  == 10'b0000000001) | (state == 10'b0000000000) & (state != 10'b0000000001));
            end
        endcase
    end

    always @(posedge done_counting) begin
        done <= Wait_next;
    end

    always @(posedge done_counting) begin
        counting <= Count_next;
    end

    always @(posedge done_counting) begin
        shift_ena <= ((state == 10'b0000000100) | (state == 10'b0000000010) | (state == 10'b0000000001) | (state == 10'b0000000000) & (state != 10'b0000000001));
    end

    always @(posedge done_counting) begin
        B3_next <= (state == 10'b0000000010);
    end

    always @(posedge done_counting) begin
        S_next <= ((state == 10'b0000000001) & (d == 0)) | ((state == 10'b0000000010) & (d == 0)) | ((state == 10'b0000000100) & (d == 0)) | ((state == 10'b0000001000) & ack);
    end

    always @(posedge done_counting) begin
        S1_next <= ((state == 10'b0000000001) & (d == 1));
    end

    always @(posedge done_counting) begin
        Count_next <= ((state == 10'b0000000010) | ((state == 10'b0000001100) & ~done_counting));
    end

    always @(posedge done_counting) begin
        Wait_next <= ((state == 10'b0000001100) & done_counting) | ((state == 10'b0000001000) & ~ack);
    end

endmodule
