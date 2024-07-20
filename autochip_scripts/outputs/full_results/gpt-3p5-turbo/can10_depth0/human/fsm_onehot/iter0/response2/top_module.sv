module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output wire out1,
    output wire out2
);
    always @(state, in)
    begin
        case (state)
            1'b1: begin // S0
                if (in == 1'b0)
                begin
                    next_state = 10'b1; // S0
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b10; // S1
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            1'b10: begin // S1
                if (in == 1'b0)
                begin
                    next_state = 10'b1; // S0
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b100; // S2
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            1'b100: begin // S2
                if (in == 1'b0)
                begin
                    next_state = 10'b1; // S0
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b1000; // S3
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            1'b1000: begin // S3
                if (in == 1'b0)
                begin
                    next_state = 10'b1; // S0
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b10000; // S4
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            1'b10000: begin // S4
                if (in == 1'b0)
                begin
                    next_state = 10'b1; // S0
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b100000; // S5
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            1'b100000: begin // S5
                if (in == 1'b0)
                begin
                    next_state = 10'b100000000; // S8
                    out1 = 1'b1;
                    out2 = 1'b0;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b1100; // S6
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            1'b1100: begin // S6
                if (in == 1'b0)
                begin
                    next_state = 10'b1000000000; // S9
                    out1 = 1'b1;
                    out2 = 1'b1;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b1000000; // S7
                    out1 = 1'b0;
                    out2 = 1'b1;
                end
            end
            1'b1000000: begin // S7
                if (in == 1'b0)
                begin
                    next_state = 10'b1; // S0
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b1000000; // S7
                    out1 = 1'b0;
                    out2 = 1'b1;
                end
            end
            1'b100000000: begin // S8
                if (in == 1'b0)
                begin
                    next_state = 10'b1; // S0
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b10; // S1
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            1'b1000000000: begin // S9
                if (in == 1'b0)
                begin
                    next_state = 10'b1; // S0
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else // in == 1'b1
                begin
                    next_state = 10'b10; // S1
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            default: begin
                next_state = 10'b0;
                out1 = 1'b0;
                out2 = 1'b0;
            end
        endcase
    end
    
endmodule
