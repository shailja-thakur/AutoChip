module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    // Always block for the next state logic
    always @(*) begin
        // Default values
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        case (state)
            10'b0000000001: begin   // S0
                if (in) next_state = 10'b0000000010;
                else next_state = 10'b0000000001;
            end
            10'b0000000010: begin   // S1
                if (in) next_state = 10'b0000000100;
                else next_state = 10'b0000000001;
            end
            10'b0000000100: begin   // S2
                if (in) next_state = 10'b0000001000;
                else next_state = 10'b0000000001;
            end
            10'b0000001000: begin   // S3
                if (in) next_state = 10'b0000010000;
                else next_state = 10'b0000000001;
            end
            10'b0000010000: begin   // S4
                if (in) next_state = 10'b0000100000;
                else next_state = 10'b0000000001;
            end
            10'b0000100000: begin   // S5
                if (in) next_state = 10'b0001000000;
                else next_state = 10'b1000000000;
            end
            10'b0001000000: begin   // S6
                if (in) next_state = 10'b0010000000;
                else next_state = 10'b0100000000;
            end
            10'b0010000000: begin   // S7
                if (in) next_state = 10'b0010000000;
                else next_state = 10'b0000000001;
                out2 = 1;
            end
            10'b0100000000: begin   // S8
                if (in) next_state = 10'b0000000010;
                else next_state = 10'b0000000001;
                out1 = 1;
            end
            10'b1000000000: begin   // S9
                if (in) next_state = 10'b0000000010;
                else next_state = 10'b0000000001;
                out1 = 1;
                out2 = 1;
            end
            default: next_state = 10'b0000000001; // Default to S0
        endcase
    end
endmodule
