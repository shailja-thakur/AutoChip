module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    // Output logic (Moore Machine)
    always @(*) begin
        case(state)
            2'b00: out = 1'b0;  // state A
            2'b01: out = 1'b0;  // state B
            2'b10: out = 1'b0;  // state C
            2'b11: out = 1'b1;  // state D
            default: out = 1'b0; // default case if needed
        endcase
    end

    // Next state logic
    always @(*) begin
        case(state)
            2'b00: next_state = (in == 1'b0) ? 2'b00 : 2'b01; // state A
            2'b01: next_state = (in == 1'b0) ? 2'b10 : 2'b01; // state B
            2'b10: next_state = (in == 1'b0) ? 2'b00 : 2'b11; // state C
            2'b11: next_state = (in == 1'b0) ? 2'b10 : 2'b01; // state D
            default: next_state = 2'b00; // default case if needed
        endcase
    end

endmodule
