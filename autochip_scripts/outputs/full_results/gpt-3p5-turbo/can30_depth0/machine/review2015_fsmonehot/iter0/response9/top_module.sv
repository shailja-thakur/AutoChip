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
 
 reg [3:0] active_states;

 always @(state) begin
    active_states = state[5:2];
 end
 
 // assign output B3_next
 always @(active_states) begin
    B3_next = (active_states == 4'b0110);
 end
 
 // assign output S_next
 always @(state, d, ack) begin
    case(state)
        4'b0010, 4'b0100, 4'b0110, 4'b1110: S_next = (d == 0);
        default: S_next = 0;
    endcase
 end
 
 // assign output S1_next
 always @(state, d) begin
    case(state)
        4'b0010: S1_next = (d == 1);
        default: S1_next = 0;
    endcase
 end
 
 // assign output Count_next
 always @(active_states, done_counting) begin
    Count_next = ((active_states == 4'b1001) || (done_counting == 0));
 end
 
 // assign output Wait_next
 always @(state, ack, done_counting) begin
    case(state)
        4'b1001: Wait_next = (done_counting == 1);
        default: Wait_next = ((state == 4'b1110) && (ack == 0));
    endcase
 end
 
 // assign other outputs
 always @(active_states) begin
    done = (state == 4'b1110);
    counting = (state == 4'b1001);
    shift_ena = (active_states != 4'b0000);
 end
 
endmodule
