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

    // States
    parameter S = 10'b0000000001;
    parameter S1 = 10'b0000000010;
    parameter S11 = 10'b0000000100;
    parameter S110 = 10'b0000001000;
    parameter B0 = 10'b0000010000;
    parameter B1 = 10'b0000100000;
    parameter B2 = 10'b0001000000;
    parameter B3 = 10'b0010000000;
    parameter Count = 10'b0100000000;
    parameter Wait = 10'b1000000000;

    // Assign next state signals
    always @(*)
    begin
        case (state)
            S: begin
                B3_next = 0;
                S_next = (d == 0);
                S1_next = (d == 1);
                Count_next = 0;
                Wait_next = 0;
            end
            
            S1: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            S11: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            S110: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            B0: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            B1: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            B2: begin
                B3_next = 1;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            B3: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            Count: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = (~done_counting);
                Wait_next = done_counting & (~ack);
            end
            
            Wait: begin
                B3_next = 0;
                S_next = ~d;
                S1_next = 0;
                Count_next = 0;
                Wait_next = (~ack);
            end
            
            default: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        endcase
    end

    // Assign done signal
    always @(state)
    begin
        done = (state == Wait);
    end

    // Assign counting signal
    always @(state)
    begin
        counting = (state == Count);
    end

    // Assign shift_ena signal
    always @(state)
    begin
        shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
    end

endmodule
