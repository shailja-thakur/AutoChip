module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default next state and outputs
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;

        // State transition logic
        case (state)
            10'b0000000001: begin // S0
                if (in) next_state = 10'b0000000010; // S1
                else next_state = 10'b0000000001; // S0
            end
            10'b0000000010: begin // S1
                if (in) next_state = 10'b0000000100; // S2
                else next_state = 10'b0000000001; // S0
            end
            10'b0000000100: begin // S2
                if (in) next_state = 10'b0000001000; // S3
                else next_state = 10'b0000000001; // S0
            end
            10'b0000001000: begin // S3
                if (in) next_state = 10'b0000010000; // S4
                else next_state = 10'b0000000001; // S0
            end
            10'b0000010000: begin // S4
                if (in) next_state = 10'b0000100000; // S5
                else next_state = 10'b0000000001; // S0
            end
            10'b0000100000: begin // S5
                if (in) next_state = 10'b0001000000; // S6
                else next_state = 10'b1000000000; // S8
            end
            10'b0001000000: begin // S6
                if (in) next_state = 10'b0010000000; // S7
                else next_state = 10'b0100000000; // S9
            end
            10'b0010000000: begin // S7
                out2 = 1;
                if (in) next_state = 10'b0010000000; // S7
                else next_state = 10'b0000000001; // S0
            end
            10'b0100000000: begin // S8
                out1 = 1;
                if (in) next_state = 10'b0000000010; // S1
                else next_state = 10'b0000000001; // S0
            end
            10'b1000000000: begin // S9
                out1 = 1;
                out2 = 1;
                if (in) next_state = 10'b0000000010; // S1
                else next_state = 10'b0000000001; // S0
            end
            default: next_state = 10'b0000000001; // Default to S0
        endcase
    end
endmodule
