module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);
    
    always @(*) begin
        // Default next state and outputs
        next_state = 10'b0;
        out1 = 1'b0;
        out2 = 1'b0;

        case (state)
            10'b0000000001: // S0
                next_state = in ? 10'b0000000010 : 10'b0000000001;
            10'b0000000010: // S1
                next_state = in ? 10'b0000000100 : 10'b0000000001;
            10'b0000000100: // S2
                next_state = in ? 10'b0000001000 : 10'b0000000001;
            10'b0000001000: // S3
                next_state = in ? 10'b0000010000 : 10'b0000000001;
            10'b0000010000: // S4
                next_state = in ? 10'b0000100000 : 10'b0000000001;
            10'b0000100000: // S5
                next_state = in ? 10'b0001000000 : 10'b1000000000;
            10'b0001000000: // S6
                next_state = in ? 10'b0010000000 : 10'b0100000000;
            10'b0010000000: // S7
                begin
                    next_state = in ? 10'b0010000000 : 10'b0000000001;
                    out2 = 1'b1;
                end
            10'b0100000000: // S8
                begin
                    next_state = in ? 10'b0000000010 : 10'b0000000001;
                    out1 = 1'b1;
                end
            10'b1000000000: // S9
                begin
                    next_state = in ? 10'b0000000010 : 10'b0000000001;
                    out1 = 1'b1;
                    out2 = 1'b1;
                end
            default:
                next_state = 10'b0000000001; // Default to S0 on invalid state
        endcase
    end

endmodule
