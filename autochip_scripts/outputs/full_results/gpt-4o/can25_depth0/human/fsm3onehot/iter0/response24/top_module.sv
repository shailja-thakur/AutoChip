module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Output logic based on state
    assign out = state[3];

    // Next state logic based on current state and input
    always @(*) begin
        case (state)
            4'b0001: next_state = in ? 4'b0010 : 4'b0001; // A -> B if in=1, else A
            4'b0010: next_state = in ? 4'b0010 : 4'b0100; // B -> B if in=1, else C
            4'b0100: next_state = in ? 4'b1000 : 4'b0001; // C -> D if in=1, else A
            4'b1000: next_state = in ? 4'b0010 : 4'b0100; // D -> B if in=1, else C
            default: next_state = 4'b0001; // Default to state A
        endcase
    end

endmodule
