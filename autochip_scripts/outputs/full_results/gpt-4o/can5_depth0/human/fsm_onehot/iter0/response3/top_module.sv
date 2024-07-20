module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);
    
    always @(*) begin
        // Default values
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;

        case (1'b1) // Using one-hot encoding for states
            state[0]: begin
                if (in) next_state[1] = 1;
                else    next_state[0] = 1;
            end
            state[1]: begin
                if (in) next_state[2] = 1;
                else    next_state[0] = 1;
            end
            state[2]: begin
                if (in) next_state[3] = 1;
                else    next_state[0] = 1;
            end
            state[3]: begin
                if (in) next_state[4] = 1;
                else    next_state[0] = 1;
            end
            state[4]: begin
                if (in) next_state[5] = 1;
                else    next_state[0] = 1;
            end
            state[5]: begin
                if (in) next_state[6] = 1;
                else    next_state[8] = 1; // State S8
            end
            state[6]: begin
                if (in) next_state[7] = 1;
                else    next_state[9] = 1; // State S9
            end
            state[7]: begin
                out2 = 1;
                if (in) next_state[7] = 1;
                else    next_state[0] = 1;
            end
            state[8]: begin
                out1 = 1;
                if (in) next_state[1] = 1;
                else    next_state[0] = 1;
            end
            state[9]: begin
                out1 = 1;
                out2 = 1;
                if (in) next_state[1] = 1;
                else    next_state[0] = 1;
            end
            default: begin
                next_state = 10'b0; // Default state
            end
        endcase
    end
endmodule
