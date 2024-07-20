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
    // Logic for B3_next output
    always @* begin
        case(state)
            B2: B3_next = 1;
            default: B3_next = 0;
        endcase
    end
    
    // Logic for S_next output
    always @* begin
        case(state)
            S:
                if (d == 0)
                    S_next = 1;
                else
                    S_next = 0;
            S1:
                if (d == 0)
                    S_next = 1;
                else
                    S_next = 0;
            S110:
                if (d == 0)
                    S_next = 1;
                else
                    S_next = 0;
            Wait:
                if (ack == 1)
                    S_next = 1;
                else
                    S_next = 0;
            default:
                S_next = 0;
        endcase
    end
    
    // Logic for S1_next output
    always @* begin
        case(state)
            S:
                if (d == 1)
                    S1_next = 1;
                else
                    S1_next = 0;
            default:
                S1_next = 0;
        endcase
    end
    
    // Logic for Count_next output
    always @* begin
        case(state)
            B3, Count:
                Count_next = 1;
            default:
                Count_next = 0;
        endcase
    end
    
    // Logic for Wait_next output
    always @* begin
        case(state)
            Count:
                if (done_counting == 1)
                    Wait_next = 1;
                else
                    Wait_next = 0;
            Wait:
                if (ack == 0)
                    Wait_next = 1;
                else
                    Wait_next = 0;
            default:
                Wait_next = 0;
        endcase
    end
    
    // Logic for done output
    always @* begin
        if (state == Wait)
            done = 1;
        else
            done = 0;
    end
    
    // Logic for counting output
    always @* begin
        if (state == Count)
            counting = 1;
        else
            counting = 0;
    end
    
    // Logic for shift_ena output
    always @* begin
        if (state == B3 || state == B2 || state == B1 || state == B0)
            shift_ena = 1;
        else
            shift_ena = 0;
    end
    
endmodule
