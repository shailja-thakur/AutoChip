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
    reg B3_next;
    reg S_next;
    reg S1_next;
    reg Count_next;
    reg Wait_next;
    
    always @* begin
        B3_next = (state == 10'b0111111111);
        S_next = (state == 10'b0000000001 && d == 1'b0) ? 1'b1 : 1'b0;
        S1_next = (state == 10'b0000000010 && d == 1'b0) ? 1'b1 : (state == 10'b0000000001 && d == 1'b1) ? 1'b1 : 1'b0;
        Count_next = (state == 10'b1000000000 && done_counting == 1'b0) ? 1'b1 : (state == 10'b1000000000 && done_counting == 1'b1) ? 1'b1 : 1'b0;
        Wait_next = (state == 10'b1000000010 && done == 1'b1 && ack == 1'b0) ? 1'b1 : (state == 10'b1000000010 && done == 1'b1 && ack == 1'b1) ? 1'b1 : 1'b0;
    end
    
    // Output logic
    assign done = (state == 10'b1000000010);
    assign counting = (state == 10'b1000000000 || state == 10'b1000000010);
    assign shift_ena = (state >= 10'b0000000001 && state <= 10'b0000000100);
endmodule
