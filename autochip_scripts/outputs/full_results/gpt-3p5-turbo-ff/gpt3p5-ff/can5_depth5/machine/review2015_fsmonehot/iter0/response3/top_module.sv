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
    output done,
    output counting,
    output shift_ena
);

reg [9:0] next_state;

always @(*) begin
    case(state)
        S: begin
            if (d == 0)
                next_state = 1;
            else
                next_state = 0;
        end
        S1: begin
            if (d == 1)
                next_state = 3;
            else
                next_state = 0;
        end
        S11: begin
            next_state = 6;
        end
        S110: begin
            if (d == 0)
                next_state = 7;
            else
                next_state = 0;
        end
        B0: begin
            next_state = 8;
        end
        B1: begin
            next_state = 9;
        end
        B2: begin
            next_state = 10;
        end
        B3: begin
            next_state = 11;
        end
        Count: begin
            if (done_counting == 0)
                next_state = 2;
            else if (done_counting == 1)
                next_state = 12;
        end
        Wait: begin
            if (ack == 1)
                next_state = 4;
            else if (ack == 0)
                next_state = 5;
        end
        default: next_state = 0;
    endcase
end

always @(posedge clk) begin
    state <= next_state;
end

always @(*) begin
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    
    case(state)
        B2: B3_next = 1;
        S: begin
            if (d == 0)
                S_next = 1;
        end
        S1: begin
            if (d == 0)
                S1_next = 1;
        end
        S110: begin
            if (d == 0)
                S_next = 1;
        end
        Wait: begin
            if (ack == 1)
                Wait_next = 1;
        end
        Count: begin
            if (done_counting == 0)
                Count_next = 1;
        end
        default: begin
            shift_ena = 0;
            counting = 0;
            done = 0;
        end
    endcase
end

always @(*) begin
    if (state == B3 || state == B2 || state == B1 || state == B0)
        shift_ena = 1;
    else
        shift_ena = 0;
    
    if (state == Count)
        counting = 1;
    else
        counting = 0;
    
    if (state == Wait)
        done = 1;
    else
        done = 0;
end

endmodule
