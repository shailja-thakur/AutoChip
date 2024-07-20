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
    wire done, counting, shift_ena;
    
    always @(*)
        case (state)
            10'b0000000001: begin
                B3_next = 1'b1;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            
            10'b0000000010: begin
                B3_next = 1'b0;
                S_next = 1'b1;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            
            10'b0000000100: begin
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b1;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            
            10'b0000001000: begin
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b1;
                Wait_next = 1'b0;
            end
            
            10'b0000010000: begin
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b1;
            end
            
            default: begin
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        endcase
    
    assign done = (state == 10'b0000010000 && done_counting);
    assign counting = (state == 10'b0000001000 || state == 10'b0000010000);
    assign shift_ena = (state >= 10'b1000000000);
    
endmodule
