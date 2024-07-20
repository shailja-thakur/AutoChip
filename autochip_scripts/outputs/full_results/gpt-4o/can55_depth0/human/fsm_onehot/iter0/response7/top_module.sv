module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Defaults
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;

        case (1'b1) // use one-hot encoding
            state[0]: 
                if (!in) next_state[0] = 1'b1; 
                else next_state[1] = 1'b1;
            state[1]: 
                if (!in) next_state[0] = 1'b1; 
                else next_state[2] = 1'b1;
            state[2]: 
                if (!in) next_state[0] = 1'b1; 
                else next_state[3] = 1'b1;
            state[3]: 
                if (!in) next_state[0] = 1'b1; 
                else next_state[4] = 1'b1;
            state[4]: 
                if (!in) next_state[0] = 1'b1; 
                else next_state[5] = 1'b1;
            state[5]: 
                if (!in) next_state[8] = 1'b1; 
                else next_state[6] = 1'b1;
            state[6]: 
                if (!in) next_state[9] = 1'b1; 
                else next_state[7] = 1'b1;
            state[7]: 
                if (!in) next_state[0] = 1'b1; 
                else next_state[7] = 1'b1;
            state[8]: 
                if (!in) next_state[0] = 1'b1; 
                else next_state[1] = 1'b1;
            state[9]: 
                if (!in) next_state[0] = 1'b1; 
                else next_state[1] = 1'b1;
            default: next_state = 10'b0;
        endcase

        // Output logic
        out1 = state[8] || state[9];
        out2 = state[7] || state[9];
    end
endmodule
