module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    // Default values
    next_state = 10'b0000000000;
    out1 = 1'b0;
    out2 = 1'b0;

    // State transition logic using one-hot encoding
    case (state)
        10'b0000000001: begin // S0
            if (in == 1'b0)
                next_state = 10'b0000000001; // Stay in S0
            else
                next_state = 10'b0000000010; // Move to S1
        end
        10'b0000000010: begin // S1
            if (in == 1'b0)
                next_state = 10'b0000000001; // Move to S0
            else
                next_state = 10'b0000000100; // Move to S2
        end
        10'b0000000100: begin // S2
            if (in == 1'b0)
                next_state = 10'b0000000001; // Move to S0
            else
                next_state = 10'b0000001000; // Move to S3
        end
        10'b0000001000: begin // S3
            if (in == 1'b0)
                next_state = 10'b0000000001; // Move to S0
            else
                next_state = 10'b0000010000; // Move to S4
        end
        10'b0000010000: begin // S4
            if (in == 1'b0)
                next_state = 10'b0000000001; // Move to S0
            else
                next_state = 10'b0000100000; // Move to S5
        end
        10'b0000100000: begin // S5
            if (in == 1'b0)
                next_state = 10'b1000000000; // Move to S8
            else
                next_state = 10'b0001000000; // Move to S6
        end
        10'b0001000000: begin // S6
            if (in == 1'b0)
                next_state = 10'b0100000000; // Move to S9
            else
                next_state = 10'b0010000000; // Move to S7
        end
        10'b0010000000: begin // S7
            if (in == 1'b0)
                next_state = 10'b0000000001; // Move to S0
            else
                next_state = 10'b0010000000; // Stay in S7
            out2 = 1'b1;
        end
        10'b0100000000: begin // S8
            if (in == 1'b0)
                next_state = 10'b0000000001; // Move to S0
            else
                next_state = 10'b0000000010; // Move to S1
            out1 = 1'b1;
        end
        10'b1000000000: begin // S9
            if (in == 1'b0)
                next_state = 10'b0000000001; // Move to S0
            else
                next_state = 10'b0000000010; // Move to S1
            out1 = 1'b1;
            out2 = 1'b1;
        end
        // Added default case to avoid latching issues
        default: begin
            next_state = 10'b0000000001; // Default to S0
        end
    endcase
end

endmodule
