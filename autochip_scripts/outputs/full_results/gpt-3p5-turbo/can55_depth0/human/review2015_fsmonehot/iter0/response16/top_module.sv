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
        case (state)
            10'b0000000001:
                begin
                    S_next = (d == 0) ? 10'b0000000001 : 10'b0000000010;
                    S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
                    B3_next = 10'b0000000010;
                    Count_next = 10'b0000000011;
                    Wait_next = 10'b0000000100;
                end

            10'b0000000010:
                begin
                    S_next = 10'b0000000001;
                    S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
                    B3_next = 10'b0000000010;
                    Count_next = 10'b0000000011;
                    Wait_next = 10'b0000000100;
                end

            10'b0000000011:
                begin
                    S_next = 10'b0000000001;
                    S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
                    B3_next = 10'b0000000010;
                    Count_next = 10'b0000000011;
                    Wait_next = 10'b0000000100;
                end

            10'b0000000100:
                begin
                    S_next = 10'b0000000001;
                    S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
                    B3_next = 10'b0000000010;
                    Count_next = 10'b0000000011;
                    Wait_next = 10'b0000000100;
                end

            10'b0000000011:
                begin
                    S_next = 10'b0000000001;
                    S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
                    B3_next = 10'b0000000010;
                    Count_next = 10'b0000000011;
                    Wait_next = 10'b0000000100;
                end

            10'b0000000100:
                begin
                    S_next = 10'b0000000001;
                    S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
                    B3_next = 10'b0000000010;
                    Count_next = (done_counting == 1) ? 10'b0000000101 : 10'b0000000011;
                    Wait_next = 10'b0000000100;
                end

            10'b0000000101:
                begin
                    S_next = 10'b0000000001;
                    S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
                    B3_next = 10'b0000000010;
                    Count_next = (done_counting == 1) ? 10'b0000000101 : 10'b0000000011;
                    Wait_next = (ack == 1) ? 10'b0000000001 : 10'b0000000100;
                end

            10'b0000000001:
                begin
                    S_next = 10'b0000000001;
                    S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
                    B3_next = 10'b0000000010;
                    Count_next = (done_counting == 1) ? 10'b0000000101 : 10'b0000000011;
                    Wait_next = (ack == 1) ? 10'b0000000001 : 10'b0000000100;
                end
        endcase
    end

    always @(posedge clk) begin
        case (state)
            10'b0000000001:
                begin
                    done = 1;
                    counting = 0;
                    shift_ena = 0;
                end

            10'b0000000010:
                begin
                    done = 0;
                    counting = 0;
                    shift_ena = 0;
                end

            10'b0000000011:
                begin
                    done = 0;
                    counting = 0;
                    shift_ena = 0;
                end

            10'b0000000011:
                begin
                    done = 0;
                    counting = 0;
                    shift_ena = 0;
                end

            10'b0000000100:
                begin
                    done = 0;
                    counting = 0;
                    shift_ena = 0;
                end

            10'b0000000011:
                begin
                    done = 0;
                    counting = 0;
                    shift_ena = 0;
                end

            10'b0000000101:
                begin
                    done = 0;
                    counting = 1;
                    shift_ena = 0;
                end

            10'b0000000001:
                begin
                    done = 0;
                    counting = 0;
                    shift_ena = 1;
                end
        endcase
    end
endmodule
