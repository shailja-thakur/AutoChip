module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @(*) begin
        // Default values to avoid latches
        next_state = 4'b0000;
        out = 0;

        // State transition logic
        case (state)
            4'b0001: begin // State A
                if (in == 0)
                    next_state = 4'b0001; // Stay in A
                else
                    next_state = 4'b0010; // Move to B
                out = 0;
            end
            4'b0010: begin // State B
                if (in == 0)
                    next_state = 4'b0100; // Move to C
                else
                    next_state = 4'b0010; // Stay in B
                out = 0;
            end
            4'b0100: begin // State C
                if (in == 0)
                    next_state = 4'b0001; // Move to A
                else
                    next_state = 4'b1000; // Move to D
                out = 0;
            end
            4'b1000: begin // State D
                if (in == 0)
                    next_state = 4'b0100; // Move to C
                else
                    next_state = 4'b0010; // Move to B
                out = 1;
            end
            default: begin
                next_state = 4'b0001; // Default to state A
                out = 0;
            end
        endcase
    end

endmodule
