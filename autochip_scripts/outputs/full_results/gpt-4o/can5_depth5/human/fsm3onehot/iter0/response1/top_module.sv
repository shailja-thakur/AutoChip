module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // State transition logic based on the state transition table provided
    always @(*) begin
        case(state)
            4'b0001: next_state = in ? 4'b0010 : 4'b0001; // A -> A if in=0, B if in=1
            4'b0010: next_state = in ? 4'b0010 : 4'b0100; // B -> C if in=0, B if in=1
            4'b0100: next_state = in ? 4'b1000 : 4'b0001; // C -> A if in=0, D if in=1
            4'b1000: next_state = in ? 4'b0010 : 4'b0100; // D -> C if in=0, B if in=1
            default: next_state = 4'b0001; // Default to state A for safety
        endcase
    end

    // Output logic based on the current state
    assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // Only state D has output 1, otherwise output is 0

endmodule
