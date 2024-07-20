module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always_comb begin
    case (state)
        2'b00: // State A
            begin
                if (in)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b00; // Next state A
            end
        2'b01: // State B
            begin
                if (in)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b10; // Next state C
            end
        2'b10: // State C
            begin
                if (in)
                    next_state = 2'b11; // Next state D
                else
                    next_state = 2'b00; // Next state A
            end
        2'b11: // State D
            begin
                if (in)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b10; // Next state C
            end
        default: // Default state
            next_state = 2'b00; // Next state A
    endcase

    out = (state == 2'b11); // Output is high when state is D
end

endmodule
