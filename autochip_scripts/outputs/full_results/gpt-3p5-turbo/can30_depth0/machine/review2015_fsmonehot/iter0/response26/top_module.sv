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

reg B3_next, S_next, S1_next, Count_next, Wait_next;
reg done, counting, shift_ena;

always @(*) begin
    case(state)
        S: begin
            if (d == 0)
                S_next = 1;
            else
                S_next = 0;
        end
        S1: begin
            if (d == 0)
                S1_next = 1;
            else
                S1_next = 0;
        end
        S110: begin
            if (d == 0)
                S_next = 1;
            else
                S_next = 0;
        end
        Wait: begin
            if (ack == 1)
                S_next = 1;
            else
                S_next = 0;
        end
        B0, B1, B2, B3: begin
            shift_ena = 1;
            B3_next = (state == B2) ? 1 : 0;
        end
        Count: begin
            counting = 1;
            if (state == B3 || done_counting == 0)
                Count_next = 1;
            else
                Count_next = 0;
        end
        default: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            shift_ena = 0;
            counting = 0;
        end
    endcase
    
    if (state == Wait && done_counting == 1)
        Wait_next = 1;
    else if (state == Wait && ack == 0)
        Wait_next = 1;
    else
        Wait_next = 0;
    
    done = (state == Wait) ? 1 : 0;
end

endmodule
