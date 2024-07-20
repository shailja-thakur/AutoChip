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
        
        case (state)
            10'b0000000001: // State S0
                if (in) next_state = 10'b0000000010; // S0 --1--> S1
                else next_state = 10'b0000000001; // S0 --0--> S0

            10'b0000000010: // State S1
                if (in) next_state = 10'b0000000100; // S1 --1--> S2
                else next_state = 10'b0000000001; // S1 --0--> S0
            
            10'b0000000100: // State S2
                if (in) next_state = 10'b0000001000; // S2 --1--> S3
                else next_state = 10'b0000000001; // S2 --0--> S0
            
            10'b0000001000: // State S3
                if (in) next_state = 10'b0000010000; // S3 --1--> S4
                else next_state = 10'b0000000001; // S3 --0--> S0
            
            10'b0000010000: // State S4
                if (in) next_state = 10'b0000100000; // S4 --1--> S5
                else next_state = 10'b0000000001; // S4 --0--> S0
            
            10'b0000100000: // State S5
                if (in) next_state = 10'b0001000000; // S5 --1--> S6
                else next_state = 10'b1000000000; // S5 --0--> S8
            
            10'b0001000000: // State S6
                if (in) next_state = 10'b0010000000; // S6 --1--> S7
                else next_state = 10'b0100000000; // S6 --0--> S9
            
            10'b0010000000: // State S7
                begin
                    out2 = 1; // S7 outputs (0, 1)
                    if (in) next_state = 10'b0010000000; // S7 --1--> S7
                    else next_state = 10'b0000000001; // S7 --0--> S0
                end

            10'b0100000000: // State S8
                begin
                    out1 = 1; // S8 outputs (1, 0)
                    if (in) next_state = 10'b0000000010; // S8 --1--> S1
                    else next_state = 10'b0000000001; // S8 --0--> S0
                end

            10'b1000000000: // State S9
                begin
                    out1 = 1; // S9 outputs (1, 1)
                    out2 = 1;
                    if (in) next_state = 10'b0000000010; // S9 --1--> S1
                    else next_state = 10'b0000000001; // S9 --0--> S0
                end

            default: next_state = 10'b0000000001; // Default to S0 for safety
        endcase
    end
endmodule
