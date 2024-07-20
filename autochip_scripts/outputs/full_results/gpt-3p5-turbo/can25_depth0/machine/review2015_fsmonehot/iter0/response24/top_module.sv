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

always @(state) begin
    case(state)
        // State S
        10'b0000000001: begin
            S_next = (d == 0) ? 1'b1 : 1'b0;
            S1_next = (d == 1) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = (d == 0 && ack == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end

        // State S1
        10'b0000000010: begin
            S_next = (d == 0) ? 1'b1 : 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = (d == 0 && ack == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end

        // State S11
        10'b0000000100: begin
            S_next = 1'b0;
            S1_next = (d == 0) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = (d == 0 && ack == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end

        // State S110
        10'b0000001000: begin
            S_next = (d == 0) ? 1'b1 : 1'b0;
            S1_next = (d == 0) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = (d == 0 && ack == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end

        // State B0
        10'b0000010000: begin
            S_next = 1'b0;
            S1_next = (d == 0) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = (d == 0 && ack == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end

        // State B1
        10'b0000100000: begin
            S_next = 1'b0;
            S1_next = (d == 0) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = (d == 0 && ack == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end

        // State B2
        10'b0001000000: begin
            S_next = 1'b0;
            S1_next = (d == 0) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = (d == 0 && ack == 1) ? 1'b1 : 1'b0;
            B3_next = (state == 10'b0000100000) ? 1'b1 : 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end

        // State B3
        10'b0010000000: begin
            S_next = 1'b0;
            S1_next = (d == 0) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = (d == 0 && ack == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end

        // State Count
        10'b0100000000: begin
            S_next = 1'b0;
            S1_next = (d == 0) ? 1'b1 : 1'b0;
            Count_next = (state == 10'b0010000000 || done_counting == 1) ? 1'b1 : 1'b0;
            Wait_next = (done_counting == 1 && ack == 0) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            done = 1'b0;
            counting = 1'b1;
            shift_ena = 1'b0;
        end

        // State Wait
        10'b1000000000: begin
            S_next = (d == 0 && ack == 1) ? 1'b1 : 1'b0;
            S1_next = (d == 1) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = (done_counting == 0 && ack == 0) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            done = (state == 10'b1000000000) ? 1'b1 : 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        default: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            B3_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
    endcase
end

assign shift_ena = (state == 10'b0001000000 || state == 10'b0000100000 || state == 10'b0000010000 || state == 10'b0000001000) ? 1'b1 : 1'b0;

endmodule
