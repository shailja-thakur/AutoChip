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
 assign S_next = (state == 10'b0000000001) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000010) : (state == 10'b0000000010) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0000000100) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0000000011) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0000000001) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0000000010) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0000000100) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0000001000) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0100000000) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0000100000) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0000010000) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0000000100) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b0010000000) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : (state == 10'b1000000000) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000100) : 10'b0000000000;
 assign S1_next = (state == 10'b0000000010) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000011) : (state == 10'b0000000011) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000011) : (state == 10'b0000000011) ? (d == 1'b0 ? 10'b0000000001 : 10'b0000000011) : 10'b0000000000;
 assign B3_next = (state == 10'b1000000000) ? 10'b0000000001 : 10'b0000000000;
 assign Count_next = (state == 10'b1000000000) ? (done_counting ? 10'b0000000100 : 10'b0000001000) : 10'b0000000000;
 assign Wait_next = (state == 10'b0000001000) ? (done ? 10'b0000000001 : 10'b0000000001) : 10'b0000000000;
 
 // Output logic
 assign done = (state == 10'b0000001000 && done == 1'b0 && ack == 1'b1) ? 1'b1 : 1'b0;
 assign counting = (state == 10'b1000000000) ? 1'b1 : 1'b0;
 assign shift_ena = (state == 10'b1000000000 || state == 10'b0100000000 || state == 10'b0010000000 || state == 10'b0001000000) ? 1'b1 : 1'b0;

endmodule
