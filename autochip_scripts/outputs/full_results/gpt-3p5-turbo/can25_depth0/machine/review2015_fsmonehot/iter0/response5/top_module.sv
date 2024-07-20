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

 // Internal signals
 reg [9:0] next_state; // Next state of the state machine
 
 // Combinational logic for next_state
 always @(*) begin
    case(state)
        // Define the next state logic for each current state
        S: begin
            if (d == 0)
                next_state = S_next ? 1 : state;
            else
                next_state = state;
        end
        S1: begin
            if (d == 0)
                next_state = S1_next ? 1 : state;
            else
                next_state = state;
        end
        S11: next_state = state;
        S110: begin
            if (d == 0)
                next_state = S_next ? 1 : state;
            else
                next_state = state;
        end
        B0: next_state = B3_next ? 1 : state;
        B1: next_state = B3_next ? 1 : state;
        B2: next_state = B3_next ? 1 : state;
        B3: next_state = B3_next ? 1 : state;
        Count: begin
            if (done_counting == 0)
                next_state = Count_next ? 1 : state;
            else
                next_state = state;
        end
        Wait: begin
            if (ack == 1)
                next_state = state;
            else
                next_state = Wait_next ? 1 : state;
        end
        default: next_state = state;
    endcase
 end

 // Sequential logic for state transition
 always @(posedge clock) begin
    if (reset)
        state <= 'b0;
    else
        state <= next_state;
 end
 
 // Output assignments
 assign S_next = (state == S || state == S1 || state == S110) && d == 0;
 assign S1_next = state == S && d == 1;
 assign B3_next = state == B2;
 assign Count_next = state == B3 || (state == Count && done_counting == 0);
 assign Wait_next = (state == Count && done_counting == 1) || (state == Wait && ack == 0);
 assign done = state == Wait;
 assign counting = state == Count;
 assign shift_ena = state == B3 || state == B2 || state == B1 || state == B0;

endmodule
