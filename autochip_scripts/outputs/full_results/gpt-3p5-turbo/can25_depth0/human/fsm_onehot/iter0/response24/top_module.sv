module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    // Assign next_state based on current state and input
    always @(state or in)
        case (state)
            // S0
            10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001;
            // S1
            10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000001;
            // S2
            10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000001;
            // S3
            10'b0000001000: next_state = in ? 10'b0000010000 : 10'b0000000001;
            // S4
            10'b0000010000: next_state = in ? 10'b0000100000 : 10'b0000000001;
            // S5
            10'b0000100000: next_state = in ? 10'b0000000001 : 10'b0001000000;
            // S6
            10'b0001000000: next_state = in ? 10'b0000000001 : 10'b0010000000;
            // S7
            10'b0010000000: next_state = in ? 10'b0000000001 : 10'b1100000000;
            // S8
            10'b0100000000: next_state = in ? 10'b0000000001 : 10'b0000000010;
            // S9
            10'b1000000000: next_state = in ? 10'b0000000001 : 10'b0000000100;
        endcase
        
    // Assign outputs based on current state
    assign out1 = (state == 10'b0010000000);
    assign out2 = (state == 10'b1000000000);
    
endmodule
