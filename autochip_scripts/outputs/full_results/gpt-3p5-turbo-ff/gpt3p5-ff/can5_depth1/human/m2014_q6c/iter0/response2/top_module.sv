module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    wire[6:1] Y_next_state;
    
    assign Y_next_state[6:1] = 7'b000001;   // State A
    assign Y_next_state[6:1] = {1'b0, y[6:2]};   // State B
    assign Y_next_state[6:1] = 7'b000100;   // State C
    assign Y_next_state[6:1] = {1'b1, y[6:2]};   // State D
    assign Y_next_state[6:1] = 7'b001000;   // State E
    assign Y_next_state[6:1] = 7'b010000;   // State F
    
    assign Y2 = Y_next_state[5];
    assign Y4 = Y_next_state[3];
endmodule
