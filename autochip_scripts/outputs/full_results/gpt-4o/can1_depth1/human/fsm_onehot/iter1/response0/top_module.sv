module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default values
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        case (state)
            10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0 -> S1 or S0
            10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1 -> S2 or S0
            10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2 -> S3 or S0
            10'b0000001000: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3 -> S4 or S0
            10'b0000010000: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4 -> S5 or S0
            10'b0000100000: next_state = in ? 10'b0001000000 : 10'b0010000000; // S5 -> S6 or S8
            10'b0001000000: next_state = in ? 10'b0100000000 : 10'b1000000000; // S6 -> S7 or S9
            10'b0010000000: begin // S8 -> S0 or S1
                next_state = in ? 10'b0000000010 : 10'b0000000001; 
                out1 = 1;
            end
            10'b0100000000: begin // S7 -> S0 or S7
                next_state = in ? 10'b0100000000 : 10'b0000000001;
                out2 = 1;
            end
            10'b1000000000: begin // S9 -> S0 or S1
                next_state = in ? 10'b0000000010 : 10'b0000000001;
                out1 = 1;
                out2 = 1;
            end
            default: next_state = 10'b0000000001; // Reset to S0
        endcase
    end
endmodule
