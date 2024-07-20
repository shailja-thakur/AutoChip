module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Define the logic equations for the states transitions and outputs
    always @(in or state) begin
        case (state)
            10'b001_000_000: begin // S0
                if (in)
                    next_state = 10'b000_001_000; // S1
                else
                    next_state = 10'b001_000_000; // S0
            end
            10'b000_001_000: begin // S1
                if (in)
                    next_state = 10'b000_010_000; // S2
                else
                    next_state = 10'b001_000_000; // S0
            end
            10'b000_010_000: begin // S2
                if (in)
                    next_state = 10'b000_100_000; // S3
                else
                    next_state = 10'b001_000_000; // S0
            end
            10'b000_100_000: begin // S3
                if (in)
                    next_state = 10'b000_000_100; // S7
                else
                    next_state = 10'b001_000_000; // S0
            end
            10'b000_101_000: begin // S4
                if (in)
                    next_state = 10'b000_000_100; // S7
                else
                    next_state = 10'b001_000_000; // S0
            end
            10'b100_000_000: begin // S5
                if (in)
                    next_state = 10'b010_000_000; // S8
                else
                    next_state = 10'b100_001_000; // S6
            end
            10'b010_000_000: begin // S6
                if (in)
                    next_state = 10'b000_100_000; // S3
                else
                    next_state = 10'b100_001_000; // S6
            end
            10'b000_000_100: begin // S7
                if (in)
                    next_state = 10'b000_000_100; // S7
                else
                    next_state = 10'b001_000_000; // S0
            end
            10'b100_001_000: begin // S8
                if (in)
                    next_state = 10'b000_001_000; // S1
                else
                    next_state = 10'b010_000_000; // S8
            end
            10'b000_000_010: begin // S9
                if (in)
                    next_state = 10'b000_001_000; // S1
                else
                    next_state = 10'b001_000_000; // S0
            end
            default:
                next_state = 10'bxxxxxxxxxx;
        endcase
    end

    assign out1 = (state[6] || state[9]);
    assign out2 = state[7];

endmodule
