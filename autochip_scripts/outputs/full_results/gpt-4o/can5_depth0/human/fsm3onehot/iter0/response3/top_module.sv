module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Combinational logic for output.
    assign out = state[3]; // The output is 1 only in state D (4'b1000). Hence, it's bit 3 of the state.

    // Combinational logic for next state.
    always @(*) begin
        case (state)
            4'b0001: next_state = in ? 4'b0010 : 4'b0001; // A
            4'b0010: next_state = in ? 4'b0010 : 4'b0100; // B
            4'b0100: next_state = in ? 4'b1000 : 4'b0001; // C
            4'b1000: next_state = in ? 4'b0010 : 4'b0100; // D
            default: next_state = 4'b0001; // Default to state A for safety
        endcase
    end

endmodule
