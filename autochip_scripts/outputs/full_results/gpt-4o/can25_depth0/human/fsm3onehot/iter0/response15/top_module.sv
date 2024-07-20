module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // State transition logic
    always @(*) begin
        case (state)
            4'b0001: // State A
                if (in == 0)
                    next_state = 4'b0001; // A -> A
                else
                    next_state = 4'b0010; // A -> B
            4'b0010: // State B
                if (in == 0)
                    next_state = 4'b0100; // B -> C
                else
                    next_state = 4'b0010; // B -> B
            4'b0100: // State C
                if (in == 0)
                    next_state = 4'b0001; // C -> A
                else
                    next_state = 4'b1000; // C -> D
            4'b1000: // State D
                if (in == 0)
                    next_state = 4'b0100; // D -> C
                else
                    next_state = 4'b0010; // D -> B
            default: 
                next_state = 4'b0001; // Default to state A if invalid state
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            4'b0001: out = 1'b0; // State A
            4'b0010: out = 1'b0; // State B
            4'b0100: out = 1'b0; // State C
            4'b1000: out = 1'b1; // State D
            default: out = 1'b0; // Default to 0 if invalid state
        endcase
    end

endmodule
