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

always @(state)
    case (state)
        10'b0000000001: begin
            B3_next = 1'b0;
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000000010: begin
            B3_next = 1'b0;
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000000100: begin
            B3_next = 1'b0;
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000001000: begin
            B3_next = 1'b0;
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000010000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000100000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0001000000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0010000000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = (ack == 1'b1);
        end
        10'b0100000000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = (done_counting == 1'b0);
            Wait_next = (ack == 1'b0);
        end
        10'b1000000000: begin
            B3_next = 1'b1;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        default: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
    endcase

always @(posedge clk)
begin
    done <= (state == 10'b1000000000);
    counting <= (state == 10'b0100000000);
    shift_ena <= (state[3] || state[2] || state[1] || state[0]);
end

endmodule
