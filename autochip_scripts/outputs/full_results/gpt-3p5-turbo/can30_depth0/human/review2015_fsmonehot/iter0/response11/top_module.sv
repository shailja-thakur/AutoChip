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

    // State transition logic
    always_comb begin
        case(state)
            // B3_next
            10'b0000000001: B3_next = shift_ena;
            
            // S_next
            10'b0000000010: S_next = (~d) & S_next;
            
            // S1_next
            10'b0000000010: S1_next = d & S1_next;
            
            // Count_next
            10'b1000000000: Count_next = (~done_counting) & Count_next;
            
            // Wait_next
            10'b1000000000: Wait_next = done & ~(ack) & Wait_next;
            
            default: B3_next = 0; S_next = 0; S1_next = 0; Count_next = 0; Wait_next = 0;
        endcase
    end

    // Output logic
    assign counting = (state == 10'b1000000000);
    assign shift_ena = (state == 10'b0000000001) || (state >= 10'b0000001111);
    assign done = (state == 10'b1000000000) & ack;

endmodule
