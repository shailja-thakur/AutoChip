module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

    always @(*) begin
        // Initialize next_state and outputs
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        // State transition logic
        if (state[0]) begin
            // S0
            next_state = in ? 10'b0000000010 : 10'b0000000001;
        end
        else if (state[1]) begin
            // S1
            next_state = in ? 10'b0000000100 : 10'b0000000001;
        end
        else if (state[2]) begin
            // S2
            next_state = in ? 10'b0000001000 : 10'b0000000001;
        end
        else if (state[3]) begin
            // S3
            next_state = in ? 10'b0000010000 : 10'b0000000001;
        end
        else if (state[4]) begin
            // S4
            next_state = in ? 10'b0000100000 : 10'b0000000001;
        end
        else if (state[5]) begin
            // S5
            next_state = in ? 10'b0001000000 : 10'b0100000000;
        end
        else if (state[6]) begin
            // S6
            next_state = in ? 10'b0010000000 : 10'b1000000000;
        end
        else if (state[7]) begin
            // S7
            next_state = in ? 10'b0010000000 : 10'b0000000001;
        end
        else if (state[8]) begin
            // S8
            next_state = in ? 10'b0000000010 : 10'b0000000001;
        end
        else if (state[9]) begin
            // S9
            next_state = in ? 10'b0000000010 : 10'b0000000001;
        end
        
        // Output logic
        if (state[8]) begin
            out1 = 1;
        end
        if (state[9]) begin
            out1 = 1;
            out2 = 1;
        end
        if (state[7]) begin
            out2 = 1;
        end
    end
endmodule
