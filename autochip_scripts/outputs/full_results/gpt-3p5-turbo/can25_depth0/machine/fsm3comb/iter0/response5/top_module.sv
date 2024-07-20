module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

//  always_comb block to define the state transitions
always_comb begin
    case (state)
        2'b00: // state A
            begin
                if (in)
                    next_state = 2'b01; // transition to state B
                else
                    next_state = 2'b00; // remain in state A
            end
        
        2'b01: // state B
            begin
                if (in)
                    next_state = 2'b01; // still in state B
                else
                    next_state = 2'b10; // transition to state C
            end
        
        2'b10: // state C
            begin
                if (in)
                    next_state = 2'b11; // transition to state D
                else
                    next_state = 2'b00; // transition to state A
            end
        
        2'b11: // state D
            begin
                if (in)
                    next_state = 2'b01; // transition to state B
                else
                    next_state = 2'b10; // transition to state C
            end
    endcase
end

// Assign output signal "out" to be high when in state D
always_comb begin
    if (state == 2'b11) // state D
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
