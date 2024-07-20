module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default assignments
        next_state = 10'b0000000000;
        out1 = 1'b0;
        out2 = 1'b0;
        
        case (state)
            10'b0000000001: // S0
                if (in) next_state = 10'b0000000010;
                else next_state = 10'b0000000001;

            10'b0000000010: // S1
                if (in) next_state = 10'b0000000100;
                else next_state = 10'b0000000001;

            10'b0000000100: // S2
                if (in) next_state = 10'b0000001000;
                else next_state = 10'b0000000001;

            10'b0000001000: // S3
                if (in) next_state = 10'b0000010000;
                else next_state = 10'b0000000001;

            10'b0000010000: // S4
                if (in) next_state = 10'b0000100000;
                else next_state = 10'b0000000001;

            10'b0000100000: // S5
                if (in) next_state = 10'b0001000000;
                else next_state = 10'b1000000000;

            10'b0001000000: // S6
                if (in) next_state = 10'b0010000000;
                else next_state = 10'b0100000000;

            10'b0010000000: // S7
                if (in) next_state = 10'b0010000000;
                else next_state = 10'b0000000001;
                out2 = 1'b1;

            10'b0100000000: // S8
                if (in) next_state = 10'b0000000010;
                else next_state = 10'b0000000001;
                out1 = 1'b1;

            10'b1000000000: // S9
                if (in) next_state = 10'b0000000010;
                else next_state = 10'b0000000001;
                out1 = 1'b1;
                out2 = 1'b1;

            default: 
                next_state = 10'b0000000001; // Default to S0
        endcase
    end

endmodule
