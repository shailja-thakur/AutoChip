module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);

    // Next state logic
    always @(*) begin
        case (state)
            4'b0001: next_state = (in) ? 4'b0010 : 4'b0001; // A: in=0 -> A, in=1 -> B
            4'b0010: next_state = (in) ? 4'b0010 : 4'b0100; // B: in=0 -> C, in=1 -> B
            4'b0100: next_state = (in) ? 4'b1000 : 4'b0001; // C: in=0 -> A, in=1 -> D
            4'b1000: next_state = (in) ? 4'b0010 : 4'b0100; // D: in=0 -> C, in=1 -> B
            default: next_state = 4'b0001; // Default to state A
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            4'b0001: out = 1'b0; // A
            4'b0010: out = 1'b0; // B
            4'b0100: out = 1'b0; // C
            4'b1000: out = 1'b1; // D
            default: out = 1'b0; // Default to 0
        endcase
    end

endmodule
