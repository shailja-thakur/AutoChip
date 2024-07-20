module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    assign next_state = state;
    wire out1, out2;

    always @* begin
        case (state)
            10'b0000000001: begin // S0
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
                out1 = 0;
                out2 = 0;
            end
            10'b0000000010: begin // S1
                if (in == 1)
                    next_state = 10'b0000000100; // S2
                else
                    next_state = 10'b0000000001; // S0
                out1 = 0;
                out2 = 0;
            end
            10'b0000000100: begin // S2
                if (in == 1)
                    next_state = 10'b0000001000; // S3
                else
                    next_state = 10'b0000000001; // S0
                out1 = 0;
                out2 = 0;
            end
            10'b0000001000: begin // S3
                if (in == 1)
                    next_state = 10'b0000010000; // S4
                else
                    next_state = 10'b0000000001; // S0
                out1 = 0;
                out2 = 0;
            end
            10'b0000010000: begin // S4
                if (in == 1)
                    next_state = 10'b0000100000; // S5
                else
                    next_state = 10'b0000000001; // S0
                out1 = 0;
                out2 = 0;
            end
            10'b0000100000: begin // S5
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0001000000; // S8
                out1 = 0;
                out2 = 0;
            end
            10'b0000000011: begin // S6
                if (in == 1)
                    next_state = 10'b0000000111; // S7
                else
                    next_state = 10'b0001001000; // S9
                out1 = 0;
                out2 = 0;
            end
            10'b0000000110: begin // S7
                if (in == 1)
                    next_state = 10'b0000000110; // S7
                else
                    next_state = 10'b0000000001; // S0
                out1 = 0;
                out2 = 1;
            end
            10'b0001000000: begin // S8
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
                out1 = 1;
                out2 = 0;
            end
            10'b0001001000: begin // S9
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
                out1 = 1;
                out2 = 1;
            end
            default: begin
                next_state = 10'b0000000001; // S0
                out1 = 0;
                out2 = 0;
            end
        endcase
    end

    assign out1 = out1;
    assign out2 = out2;

endmodule
