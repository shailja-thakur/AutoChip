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
    if (state[0]) begin // S0
        if (in == 0)
            next_state = 10'b0000000001; // Stay in S0
        else
            next_state = 10'b0000000010; // Move to S1
    end
    else if (state[1]) begin // S1
        if (in == 0)
            next_state = 10'b0000000001; // Move to S0
        else
            next_state = 10'b0000000100; // Move to S2
    end
    else if (state[2]) begin // S2
        if (in == 0)
            next_state = 10'b0000000001; // Move to S0
        else
            next_state = 10'b0000001000; // Move to S3
    end
    else if (state[3]) begin // S3
        if (in == 0)
            next_state = 10'b0000000001; // Move to S0
        else
            next_state = 10'b0000010000; // Move to S4
    end
    else if (state[4]) begin // S4
        if (in == 0)
            next_state = 10'b0000000001; // Move to S0
        else
            next_state = 10'b0000100000; // Move to S5
    end
    else if (state[5]) begin // S5
        if (in == 0)
            next_state = 10'b1000000000; // Move to S8
        else
            next_state = 10'b0001000000; // Move to S6
    end
    else if (state[6]) begin // S6
        if (in == 0)
            next_state = 10'b0100000000; // Move to S9
        else
            next_state = 10'b0010000000; // Move to S7
    end
    else if (state[7]) begin // S7
        if (in == 0)
            next_state = 10'b0000000001; // Move to S0
        else
            next_state = 10'b0010000000; // Stay in S7
        out2 = 1;
    end
    else if (state[8]) begin // S8
        if (in == 0)
            next_state = 10'b0000000001; // Move to S0
        else
            next_state = 10'b0000000010; // Move to S1
        out1 = 1;
    end
    else if (state[9]) begin // S9
        if (in == 0)
            next_state = 10'b0000000001; // Move to S0
        else
            next_state = 10'b0000000010; // Move to S1
        out1 = 1;
        out2 = 1;
    end
    else begin
        next_state = 10'b0000000001; // Default to S0 if no valid state is set
    end
end

endmodule
