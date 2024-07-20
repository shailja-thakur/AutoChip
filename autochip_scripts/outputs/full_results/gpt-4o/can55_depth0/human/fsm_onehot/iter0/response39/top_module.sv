module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default output values
        out1 = 0;
        out2 = 0;

        // Set the next state to 0 by default (one hot encoding)
        next_state = 10'b0000000000;

        case (state)
            10'b0000000001: begin // S0
                if (in)
                    next_state = 10'b0000000010; // to S1
                else
                    next_state = 10'b0000000001; // stay in S0
            end

            10'b0000000010: begin // S1
                if (in)
                    next_state = 10'b0000000100; // to S2
                else
                    next_state = 10'b0000000001; // to S0
            end

            10'b0000000100: begin // S2
                if (in)
                    next_state = 10'b0000001000; // to S3
                else
                    next_state = 10'b0000000001; // to S0
            end

            10'b0000001000: begin // S3
                if (in)
                    next_state = 10'b0000010000; // to S4
                else
                    next_state = 10'b0000000001; // to S0
            end

            10'b0000010000: begin // S4
                if (in)
                    next_state = 10'b0000100000; // to S5
                else
                    next_state = 10'b0000000001; // to S0
            end

            10'b0000100000: begin // S5
                if (in)
                    next_state = 10'b0001000000; // to S6
                else
                    next_state = 10'b1000000000; // to S8
            end

            10'b0001000000: begin // S6
                if (in)
                    next_state = 10'b0010000000; // to S7
                else
                    next_state = 10'b0100000000; // to S9
            end

            10'b0010000000: begin // S7
                out2 = 1;
                if (in)
                    next_state = 10'b0010000000; // stay in S7
                else
                    next_state = 10'b0000000001; // to S0
            end

            10'b0100000000: begin // S8
                out1 = 1;
                if (in)
                    next_state = 10'b0000000010; // to S1
                else
                    next_state = 10'b0000000001; // to S0
            end

            10'b1000000000: begin // S9
                out1 = 1;
                out2 = 1;
                if (in)
                    next_state = 10'b0000000010; // to S1
                else
                    next_state = 10'b0000000001; // to S0
            end

            default: begin
                next_state = 10'b0000000001; // default to S0
            end
        endcase
    end
endmodule
