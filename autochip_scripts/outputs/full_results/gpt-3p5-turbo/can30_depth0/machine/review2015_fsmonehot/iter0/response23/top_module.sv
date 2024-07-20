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
 
    // Assign statements for outputs
    assign done = (state == 10'h00003);   // state Wait
    assign counting = (state == 10'h00002);   // state Count
    assign shift_ena = (state[6] || state[5] || state[4] || state[3]);   // states B3, B2, B1, B0
    
    // Next state logic
    always @(*)
    begin
        case(state)
            
            // State S
            10'h00001:   // state S
                if (d == 0)
                    S_next = 1'b1;
                else
                    S_next = 1'b0;
                
            // State S1
            10'h00004:   // state S1
                if (d == 0)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
                
            // State S11
            10'h00005:   // state S11
                S1_next = 1'b0;
                
            // State S110
            10'h00006:   // state S110
                if (d == 0)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
                
            // State B0
            10'h00007:   // state B0
                
            // State B1
            10'h00008:   // state B1
                
            // State B2
            10'h00009:   // state B2
                B3_next = 1'b1;
                
            // State B3
            10'h0000A:   // state B3
                B3_next = 1'b0;
                
            // State Count
            10'h00002:   // state Count
                if (done_counting == 0 || state == 10'h0000A)    // done_counting is 0 or state B3
                    Count_next = 1'b1;
                else
                    Count_next = 1'b0;
                
            // State Wait
            10'h00003:   // state Wait    
                if (ack == 1 || state == 10'h00002)    // ack is 1 or state Count
                    Wait_next = 1'b0;
                else
                    Wait_next = 1'b1;
                
        endcase
    end
endmodule
