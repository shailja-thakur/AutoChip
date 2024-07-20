module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);
    // Combinational logic for state transition
    always @(*) begin
        case (state)
            4'b0001: // State A
                if (in == 1'b0)
                    next_state = 4'b0001; // Stay in A
                else
                    next_state = 4'b0010; // Go to B
            4'b0010: // State B
                if (in == 1'b0)
                    next_state = 4'b0100; // Go to C
                else
                    next_state = 4'b0010; // Stay in B
            4'b0100: // State C
                if (in == 1'b0)
                    next_state = 4'b0001; // Go to A
                else
                    next_state = 4'b1000; // Go to D
            4'b1000: // State D
                if (in == 1'b0)
                    next_state = 4'b0100; // Go to C
                else
                    next_state = 4'b0010; // Go to B
            default: 
                next_state = 4'b0001; // Default to state A
        endcase
    end

    // Combinational logic for output
    always @(*) begin
        case (state)
            4'b1000: // State D
                out = 1'b1;
            default:
                out = 1'b0;
        endcase
    end
endmodule
