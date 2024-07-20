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

reg [9:0] next_state;

always @(*) begin
    case (state)
        S: begin
            if (d == 0)
                next_state = S_next;
            else
                next_state = S1_next;
        end
        S1: begin
            if (d == 0)
                next_state = S110;
            else
                next_state = S1_next;
        end
        S110: begin
            if (d == 0)
                next_state = Wait;
            else
                next_state = S1_next;
        end
        Wait: begin
            if (ack == 1)
                next_state = Wait_next;
            else
                next_state = Wait;
        end
        default: next_state = state;
    endcase
end

always @(posedge clk) begin
    state <= next_state;
end

always @(*) begin
    B3_next = (state == B2);
    S_next = ((state == S) && (d == 0)) || ((state == S1) && (d == 0)) || ((state == S110) && (d == 0)) || ((state == Wait) && (ack == 1));
    S1_next = (state == S) && (d == 1);
    Count_next = (state == B3) || ((state == Count) && (done_counting == 0));
    Wait_next = ((state == Count) && (done_counting == 1)) || ((state == Wait) && (ack == 0));
end

assign done = (state == Wait);
assign counting = (state == Count);
assign shift_ena = (state == B3) || (state == B2) || (state == B1) || (state == B0);

endmodule
