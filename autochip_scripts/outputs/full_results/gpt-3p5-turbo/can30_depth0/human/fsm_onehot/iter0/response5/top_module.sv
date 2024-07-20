module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    // Output and next state definition
    reg [9:0] next_state;
    wire out1;
    wire out2;
    
    // State transition logic
    always @(state, in) begin
        case(state)
            10'b0000000001: next_state = 10'b0000000001; // S0 (0, 0) --0--> S0
            10'b0000000001: next_state = 10'b0000000010; // S0 (0, 0) --1--> S1
            10'b0000000010: next_state = 10'b0000000001; // S1 (0, 0) --0--> S0
            10'b0000000010: next_state = 10'b0000000100; // S1 (0, 0) --1--> S2
            10'b0000000100: next_state = 10'b0000000001; // S2 (0, 0) --0--> S0
            10'b0000000100: next_state = 10'b0000001000; // S2 (0, 0) --1--> S3
            10'b0000001000: next_state = 10'b0000000001; // S3 (0, 0) --0--> S0
            10'b0000001000: next_state = 10'b0000010000; // S3 (0, 0) --1--> S4
            10'b0000010000: next_state = 10'b0000000001; // S4 (0, 0) --0--> S0
            10'b0000010000: next_state = 10'b0000100000; // S4 (0, 0) --1--> S5
            10'b0000100000: next_state = 10'b0010000000; // S5 (0, 0) --0--> S8
            10'b0000100000: next_state = 10'b0001000000; // S5 (0, 0) --1--> S6
            10'b0001000000: next_state = 10'b0100000000; // S6 (0, 0) --0--> S9
            10'b0001000000: next_state = 10'b0010000000; // S6 (0, 0) --1--> S7
            10'b0100000000: next_state = 10'b0000000001; // S7 (0, 1) --0--> S0
            10'b0100000000: next_state = 10'b0100000000; // S7 (0, 1) --1--> S7
            10'b0010000000: next_state = 10'b0000000001; // S8 (1, 0) --0--> S0
            10'b0010000000: next_state = 10'b0000000010; // S8 (1, 0) --1--> S1
            10'b0100000000: next_state = 10'b0000000001; // S9 (1, 1) --0--> S0
            10'b0100000000: next_state = 10'b0000000010; // S9 (1, 1) --1--> S1
            default: next_state = 10'b0000000000; // Default case
        endcase
    end
    
    // Output logic
    assign out1 = (state == 10'b0100000000) ? 1'b0 : 1'b0; // Output out1 logic
    assign out2 = (state == 10'b0100000000) ? 1'b1 : 1'b0; // Output out2 logic
    
endmodule
