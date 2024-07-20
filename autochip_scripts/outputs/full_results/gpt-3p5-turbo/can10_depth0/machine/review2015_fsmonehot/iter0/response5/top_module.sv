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
        // S state
        10'b0 : begin
            S_next = (d == 0);
            S1_next = (d == 1);
            Count_next = 0;
            Wait_next = (ack == 1);
            B3_next = 0;
         end
        // S1 state
        10'b1 : begin
            S_next = (d == 0);
            S1_next = (d == 1);
            Count_next = 0;
            Wait_next = (ack == 1);
            B3_next = 0;
        end
        // S11 state
        10'b10 : begin
            S_next = (d == 0);
            S1_next = (d == 1);
            Count_next = 0;
            Wait_next = (ack == 1);
            B3_next = 0;
        end
        // S110 state
        10'b11 : begin
            S_next = (d == 0);
            S1_next = 0;
            Count_next = 0;
            Wait_next = (ack == 1);
            B3_next = 0;
        end
        // B0 state
        10'b100 : begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = (ack == 1);
            B3_next = 0;
        end
        // B1 state
        10'b101 : begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = (ack == 1);
            B3_next = 0;
        end
        // B2 state
        10'b110 : begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = (ack == 1);
            B3_next = 1;
        end
        // B3 state
        10'b111 : begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = (ack == 1);
            B3_next = 0;
        end
        // Count state
        10'b1000 : begin
            S_next = 0;
            S1_next = 0;
            Count_next = (done_counting == 0);
            Wait_next = (ack == 1);
            B3_next = 0;
        end
        // Wait state
        10'b1001 : begin
            S_next = 0;
            S1_next = 0;
            Count_next = (done_counting == 1);
            Wait_next = (ack == 1);
            B3_next = 0;
        end
        default : begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
        end
    endcase
end

always @(posedge clk) begin
    counting <= Count_next;
    done <= Wait_next;
    shift_ena <= (B3_next || B2_next || B1_next || B0_next);
end

endmodule
