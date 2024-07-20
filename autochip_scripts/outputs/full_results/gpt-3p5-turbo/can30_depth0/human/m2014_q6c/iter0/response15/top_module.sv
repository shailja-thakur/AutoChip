module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Define internal signals
    wire A, B, C, D, E, F;

    // Output Y2 and Y4 signals based on current state
    assign Y2 = (y[6] && !y[5]) || (y[5] && !y[4]) || (y[3] && !y[2]) || (y[2] && !w) || (y[1] && w);
    assign Y4 = (y[6] && !y[4]) || (y[5] && !y[3]) || (y[4] && !y[2]) || (y[3] && !w) || (y[2] && w);

    // Define the state machine logic
    always @* begin
        case (y)
            7'b0000001: begin // State A
                A = 1'b1;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
            end
            7'b0000010: begin // State B
                A = 1'b0;
                B = 1'b1;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
            end
            7'b0000100: begin // State C
                A = 1'b0;
                B = 1'b0;
                C = 1'b1;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
            end
            7'b0001000: begin // State D
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b1;
                E = 1'b0;
                F = 1'b0;
            end
            7'b0010000: begin // State E
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b1;
                F = 1'b0;
            end
            7'b0100000: begin // State F
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b1;
            end
            default: begin // Default case
                A = 1'b1;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
            end
        endcase
    end

endmodule
