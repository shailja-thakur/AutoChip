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
        case (state)
            // State S
            10'b0000000001: begin
                S_next = d ? 10'b0000000010 : 10'b0000000001;
                S1_next = 10'b0000000001;
                Count_next = 10'b0000000001;
                Wait_next = 10'b0000000001;
                B3_next = 10'b0000000001;
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
            
            // State S1
            10'b0000000010: begin
                S_next = d ? 10'b0000000100 : 10'b0000000001;
                S1_next = d ? 10'b0000000011 : 10'b0000000010;
                Count_next = 10'b0000000010;
                Wait_next = 10'b0000000010;
                B3_next = 10'b0000000010;
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
            
            // State S11
            10'b0000000011: begin
                S_next = 10'b0000000001;
                S1_next = d ? 10'b0000000111 : 10'b0000000010;
                Count_next = 10'b0000000011;
                Wait_next = 10'b0000000011;
                B3_next = 10'b0000000011;
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
            
            // State S110
            10'b0000000100: begin
                S_next = d ? 10'b0000000001 : 10'b0000000100;
                S1_next = 10'b0000000001;
                Count_next = 10'b0000000100;
                Wait_next = 10'b0000000100;
                B3_next = 10'b0000000100;
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
            
            // State B0
            10'b0000000101: begin
                S_next = 10'b0000000001;
                S1_next = 10'b0000000001;
                Count_next = 10'b0000000101;
                Wait_next = 10'b0000000101;
                B3_next = 10'b0000000101;
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
            
            // State B1
            10'b0000000110: begin
                S_next = 10'b0000000001;
                S1_next = 10'b0000000001;
                Count_next = 10'b0000000110;
                Wait_next = 10'b0000000110;
                B3_next = 10'b0000000110;
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
            
            // State B2
            10'b0000000111: begin
                S_next = 10'b0000000001;
                S1_next = 10'b0000000001;
                Count_next = 10'b0000000111;
                Wait_next = 10'b0000000111;
                B3_next = 10'b0000000111;
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
            
            // State B3
            10'b0000001000: begin
                S_next = 10'b0000000001;
                S1_next = 10'b0000000001;
                Count_next = 10'b0000001000;
                Wait_next = 10'b0000001000;
                B3_next = 10'b0000001000;
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
            
            // State Count
            10'b0000001001: begin
                S_next = 10'b0000000001;
                S1_next = 10'b0000000001;
                Count_next = done_counting ? 10'b0100001001 : 10'b0000001001;
                Wait_next = done_counting ? 10'b0110001001 : 10'b0000001001;
                B3_next = 10'b0000001001;
                done = 1'b0;
                counting = 1'b1;
                shift_ena = 1'b0;
            end
            
            // State Wait
            10'b0000001010: begin
                S_next = 10'b0000000001;
                S1_next = 10'b0000000001;
                Count_next = 10'b0000000001;
                Wait_next = ack ? 10'b0000011010 : 10'b0000001010;
                B3_next = 10'b0000001010;
                done = 1'b1;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
            
            default: begin
                S_next = 10'b0000000001;
                S1_next = 10'b0000000001;
                Count_next = 10'b0000000001;
                Wait_next = 10'b0000000001;
                B3_next = 10'b0000000001;
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
        endcase
    end
    
endmodule
