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
    wire shift_ena;

    assign shift_ena = (state[3] || state[2] || state[1] || state[0]);

    always @* begin
        case(state)
            S: begin
                if(d == 0)
                    S_next = 1;
                else
                    S_next = 0;
                
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            S1: begin
                if(d == 0)
                    S_next = 1;
                else
                    S_next = 0;
                
                S1_next = 1;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            S11: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            S110: begin
                if(d == 0)
                    S_next = 1;
                else
                    S_next = 0;
                
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            B0: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            B1: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            B2: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 1;
                Count_next = 0;
                Wait_next = 0;
            end
            
            B3: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            Count: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                if(done_counting == 0)
                    Count_next = 1;
                else
                    Count_next = 0;
                
                Wait_next = 0;
            end
            
            Wait: begin
                if(ack == 1)
                    S_next = 0;
                else
                    S_next = 1;
                
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                
                if(ack == 0)
                    Wait_next = 1;
                else
                    Wait_next = 0;
            end
        endcase
    end

    always @(posedge clk) begin
        if(Count_next == 1)
            counting = 1;
        else
            counting = 0;
    end
 
    always @(posedge clk) begin
        if(Wait_next == 1)
            done = 1;
        else
            done = 0;
    end

endmodule
