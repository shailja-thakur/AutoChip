module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default values
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;

        case (1'b1) // S0
            state[0]: 
                next_state = (in == 1'b0) ? 10'b0000000001 :
                             (in == 1'b1) ? 10'b0000000010 : 10'b0000000001; 
            state[1]: // S1
                next_state = (in == 1'b0) ? 10'b0000000001 : 
                             (in == 1'b1) ? 10'b0000000100 : 10'b0000000010;
            state[2]: // S2
                next_state = (in == 1'b0) ? 10'b0000000001 : 
                             (in == 1'b1) ? 10'b0000001000 : 10'b0000000100;
            state[3]: // S3
                next_state = (in == 1'b0) ? 10'b0000000001 : 
                             (in == 1'b1) ? 10'b0000010000 : 10'b0000001000;
            state[4]: // S4
                next_state = (in == 1'b0) ? 10'b0000000001 : 
                             (in == 1'b1) ? 10'b0000100000 : 10'b0000010000;
            state[5]: // S5
                next_state = (in == 1'b0) ? 10'b0001000000 : 
                             (in == 1'b1) ? 10'b0001000000 : 10'b0000100000;
            state[6]: // S6
                next_state = (in == 1'b0) ? 10'b0010000000 : 
                             (in == 1'b1) ? 10'b0100000000 : 10'b0010000000;
            state[7]: // S7
                next_state = (in == 1'b0) ? 10'b0000000001 : 
                             (in == 1'b1) ? 10'b1000000000 : 10'b0100000000;
                out2 = 1;
            state[8]: // S8
                next_state = (in == 1'b0) ? 10'b0000000001 : 
                             (in == 1'b1) ? 10'b0000000010 : 10'b0010000000;
                out1 = 1;
            state[9]: // S9
                next_state = (in == 1'b0) ? 10'b0000000001 : 
                             (in == 1'b1) ? 10'b0000000010 : 10'b1000000000;
                out1 = 1;
                out2 = 1;
            default: next_state = 10'b0000000001; // default to S0
        endcase
    end

endmodule
