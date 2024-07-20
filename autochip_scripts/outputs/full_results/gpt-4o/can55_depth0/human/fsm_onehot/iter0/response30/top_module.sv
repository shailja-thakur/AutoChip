module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    always @(*) begin
        // Default next_state is all zeros
        next_state = 10'd0;
        
        if (state[0]) begin
            if (in)
                next_state[1] = 1;
            else
                next_state[0] = 1;
        end
        else if (state[1]) begin
            if (in)
                next_state[2] = 1;
            else
                next_state[0] = 1;
        end
        else if (state[2]) begin
            if (in)
                next_state[3] = 1;
            else
                next_state[0] = 1;
        end
        else if (state[3]) begin
            if (in)
                next_state[4] = 1;
            else
                next_state[0] = 1;
        end
        else if (state[4]) begin
            if (in)
                next_state[5] = 1;
            else
                next_state[0] = 1;
        end
        else if (state[5]) begin
            if (in)
                next_state[6] = 1;
            else
                next_state[8] = 1;
        end
        else if (state[6]) begin
            if (in)
                next_state[7] = 1;
            else
                next_state[9] = 1;
        end
        else if (state[7]) begin
            if (in)
                next_state[7] = 1;
            else
                next_state[0] = 1;
        end
        else if (state[8]) begin
            if (in)
                next_state[1] = 1;
            else
                next_state[0] = 1;
        end
        else if (state[9]) begin
            if (in)
                next_state[1] = 1;
            else
                next_state[0] = 1;
        end
    end

    // Output Logic
    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];

endmodule
