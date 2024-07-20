module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

    // Combinational logic for next state
    always @(*) begin
        case (state)
            2'b00:  // State A
                if (in == 1'b0)
                    next_state = 2'b00; // remains in A
                else
                    next_state = 2'b01; // transition to B
            2'b01:  // State B
                if (in == 1'b0)
                    next_state = 2'b10; // transition to C
                else
                    next_state = 2'b01; // remains in B
            2'b10:  // State C
                if (in == 1'b0)
                    next_state = 2'b00; // transition to A
                else
                    next_state = 2'b11; // transition to D
            2'b11:  // State D
                if (in == 1'b0)
                    next_state = 2'b10; // transition to C
                else
                    next_state = 2'b01; // transition to B
            default: next_state = 2'b00; // Default to state A for safety
        endcase
    end

    // Combinational logic for output
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
