module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Output logic
    assign out = state[3];  // Only in state D, which is 4'b1000, the output is 1

    // Next state logic
    always @(*) begin
        case(state)
            4'b0001: next_state = (in == 0) ? 4'b0001 : 4'b0010; // A
            4'b0010: next_state = (in == 0) ? 4'b0100 : 4'b0010; // B
            4'b0100: next_state = (in == 0) ? 4'b0001 : 4'b1000; // C
            4'b1000: next_state = (in == 0) ? 4'b0100 : 4'b0010; // D
            default: next_state = 4'b0001; // Default to state A
        endcase
    end
    
endmodule
