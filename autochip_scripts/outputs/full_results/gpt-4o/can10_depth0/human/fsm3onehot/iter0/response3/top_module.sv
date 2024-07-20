module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // State transition logic
    always @(*) begin
        case (state)
            4'b0001: begin // State A
                if (in == 0)
                    next_state = 4'b0001; // Remain in A
                else
                    next_state = 4'b0010; // Move to B
            end
            4'b0010: begin // State B
                if (in == 0)
                    next_state = 4'b0100; // Move to C
                else
                    next_state = 4'b0010; // Remain in B
            end
            4'b0100: begin // State C
                if (in == 0)
                    next_state = 4'b0001; // Move to A
                else
                    next_state = 4'b1000; // Move to D
            end
            4'b1000: begin // State D
                if (in == 0)
                    next_state = 4'b0100; // Move to C
                else
                    next_state = 4'b0010; // Move to B
            end
            default: next_state = 4'b0001; // Default to state A
        endcase
    end

    // Output logic
    assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output is 1 only in state D

endmodule
