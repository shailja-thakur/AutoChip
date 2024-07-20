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
    output reg done,
    output reg counting,
    output reg shift_ena
 );

always @(state)
begin
    // State transition logic
    case (state)
        10'b1000000000: B3_next = 1'b1;
        10'b0000000001: S_next = (d == 1'b0);
        10'b0000000010: S1_next = (d == 1'b1);
        10'b1000000100: Count_next = 1'b1;
        10'b0100001000: Wait_next = 1'b1;
        default: begin
                     B3_next = 1'b0;
                     S_next = 1'b0;
                     S1_next = 1'b0;
                     Count_next = 1'b0;
                     Wait_next = 1'b0;
                 end
    endcase
end

always @(state, ack)
begin
    // Output logic
    case (state)
        10'b0100001000: done = (ack == 1'b0);
        default: done = 1'b0;
    endcase
end

always @(state)
begin
    counting = (state[7] | state[8] | state[9]);
    shift_ena = (state[7] | state[8] | state[9]);
end

endmodule
