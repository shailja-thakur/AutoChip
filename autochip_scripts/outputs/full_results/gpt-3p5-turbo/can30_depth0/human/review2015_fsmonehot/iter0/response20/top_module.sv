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

 // Next-state logic
 always @(*)
 begin
    case(state)
        10'b0000000001: B3_next = 1'b1;
        10'b0000000010: S_next = d;
        10'b0000000100: S1_next = d;
        10'b0010000000: Count_next = ~done_counting;
        10'b0100000000: Wait_next = done;
        default: begin
                  B3_next = 1'b0;
                  S_next = 1'b0;
                  S1_next = 1'b0;
                  Count_next = 1'b0;
                  Wait_next = 1'b0;
                 end
    endcase
 end

 // Output logic
 assign done = (state == 10'b0100000000);
 assign counting = (state == 10'b0010000000);
 assign shift_ena = (state >= 10'b1000000000);

endmodule
