module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case(state)
        4'b0001: // State A
            if (in == 0)
                next_state = 4'b0001; // Next state is A
            else
                next_state = 4'b0010; // Next state is B
        4'b0010: // State B
            if (in == 0)
                next_state = 4'b0100; // Next state is C
            else
                next_state = 4'b0010; // Next state is B
        4'b0100: // State C
            if (in == 0)
                next_state = 4'b0001; // Next state is A
            else
                next_state = 4'b1000; // Next state is D
        4'b1000: // State D
            if (in == 0)
                next_state = 4'b0100; // Next state is C
            else
                next_state = 4'b0010; // Next state is B
        default:
            next_state = 4'b0001; // Default to state A
    endcase

    out = (state == 4'b1000) ? 1 : 0; // Output is 1 when in state D, 0 otherwise
end

endmodule
