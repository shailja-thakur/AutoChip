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
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    
    case (state)
        S: begin
            if (d == 0)
                S_next = 1;
            else if (d == 1)
                S1_next = 1;
        end
        S1: begin
            if (d == 0)
                S_next = 1;
        end
        S110: begin
            if (d == 0)
                S_next = 1;
        end
        Wait: begin
            if (ack == 1)
                S_next = 1;
        end
        B3: begin
            B3_next = 1;
        end
        Count: begin
            if (done_counting == 0)
                Count_next = 1;
            else if (done_counting == 1)
                Wait_next = 1;
        end
    endcase
end

always @(state) begin
    done = (state == Wait);
    counting = (state == Count);
    shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
end
 
endmodule
