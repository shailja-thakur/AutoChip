module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // State transition logic
    always @(*) begin
        case (state)
            4'b0001: next_state = in ? 4'b0010 : 4'b0001; // A
            4'b0010: next_state = in ? 4'b0010 : 4'b0100; // B
            4'b0100: next_state = in ? 4'b1000 : 4'b0001; // C
            4'b1000: next_state = in ? 4'b0010 : 4'b0100; // D
            default: next_state = 4'b0001; // Default to state A if not in any valid state
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            4'b0001: out = 0; // A
            4'b0010: out = 0; // B
            4'b0100: out = 0; // C
            4'b1000: out = 1; // D
            default: out = 0; // Default output
        endcase
    end

endmodule
