module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

reg B3_next;
reg S_next;
reg S1_next;
reg Count_next;
reg Wait_next;
reg done;
reg counting;
reg shift_ena;

 always @* begin
    case(state)
        10'b0000000001: begin
                            S_next = (~d);
                            S1_next = (d & ~done_counting);
                            Count_next = 0;
                            Wait_next = 0;
                            B3_next = 0;
                       end
        10'b0000000010: begin
                            S_next = 1;
                            S1_next = (d & ~done_counting);
                            Count_next = 0;
                            Wait_next = 0;
                            B3_next = 0;
                       end
        10'b0000000100: begin
                            S_next = 0;
                            S1_next = 1;
                            Count_next = 0;
                            Wait_next = 0;
                            B3_next = 0;
                       end
        10'b0000001000: begin
                            S_next = 0;
                            S1_next = 0;
                            Count_next = 0;
                            Wait_next = 0;
                            B3_next = 0;
                       end
        10'b0000010000: begin
                            S_next = 0;
                            S1_next = 0;
                            Count_next = 0;
                            Wait_next = 0;
                            B3_next = 0;
                       end
        10'b0000100000: begin
                            S_next = 0;
                            S1_next = 0;
                            Count_next = 0;
                            Wait_next = 0;
                            B3_next = 0;
                       end
        10'b0001000000: begin
                            S_next = 0;
                            S1_next = 0;
                            Count_next = 1;
                            Wait_next = 0;
                            B3_next = 0;
                       end
        10'b0010000000: begin
                            S_next = 0;
                            S1_next = 0;
                            Count_next = 1;
                            Wait_next = 0;
                            B3_next = 0;
                       end
        10'b0100000000: begin
                            S_next = 0;
                            S1_next = 0;
                            Count_next = counting & ~done_counting;
                            Wait_next = 0;
                            B3_next = 0;
                       end
        10'b1000000000: begin
                            S_next = 0;
                            S1_next = 0;
                            Count_next = 0;
                            Wait_next = 1;
                            B3_next = 0;
                       end
    endcase
end

always @* begin
    case(state)
        10'b0000000001: begin
                            done = 0;
                            counting = 0;
                            shift_ena = 0;
                       end
        10'b0000000010: begin
                            done = 0;
                            counting = 0;
                            shift_ena = 0;
                       end
        10'b0000000100: begin
                            done = 0;
                            counting = 0;
                            shift_ena = 1;
                       end
        10'b0000001000: begin
                            done = 0;
                            counting = 0;
                            shift_ena = 1;
                       end
        10'b0000010000: begin
                            done = 0;
                            counting = 0;
                            shift_ena = 1;
                       end
        10'b0000100000: begin
                            done = 0;
                            counting = 0;
                            shift_ena = 1;
                       end
        10'b0001000000: begin
                            done = 0;
                            counting = 1;
                            shift_ena = 1;
                       end
        10'b0010000000: begin
                            done = 0;
                            counting = 1;
                            shift_ena = 1;
                       end
        10'b0100000000: begin
                            done = 1;
                            counting = 1;
                            shift_ena = 1;
                       end
        10'b1000000000: begin
                            done = 1;
                            counting = 0;
                            shift_ena = 0;
                       end
    endcase
end

endmodule
