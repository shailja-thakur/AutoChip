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
    reg B3_next_reg;
    reg S_next_reg;
    reg S1_next_reg;
    reg Count_next_reg;
    reg Wait_next_reg;
    reg done_reg;
    reg counting_reg;
    reg shift_ena_reg;
    
    // State transition logic
    always_comb begin
        case(state)
            10'b0111111111: B3_next_reg = 1'b1;
            default: B3_next_reg = 1'b0;
        endcase
        
        case(state)
            10'b0000000001: S_next_reg = 1'b1;
            default: S_next_reg = 1'b0;
        endcase
        
        case(state)
            10'b0000000010: S1_next_reg = 1'b1;
            default: S1_next_reg = 1'b0;
        endcase
        
        case(state[9])
            1'b1: Count_next_reg = (~done_counting) ? 1'b1 : 1'b0;
            default: Count_next_reg = 1'b0;
        endcase
        
        case(state[9])
            1'b1: Wait_next_reg = (ack) ? 1'b1 : 1'b0;
            default: Wait_next_reg = 1'b0;
        endcase
    end
    
    // Output logic
    always_comb begin
        done_reg = (state == 10'b1000000000);
        counting_reg = state[9];
        shift_ena_reg = (state == 10'b1000000100);
    end
    
    // Assign registered values to outputs
    assign B3_next = B3_next_reg;
    assign S_next = S_next_reg;
    assign S1_next = S1_next_reg;
    assign Count_next = Count_next_reg;
    assign Wait_next = Wait_next_reg;
    assign done = done_reg;
    assign counting = counting_reg;
    assign shift_ena = shift_ena_reg;
endmodule
