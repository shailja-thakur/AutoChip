module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always_comb begin
    case (state)
        2'b00: begin // state A
            if (in)
                next_state = 2'b01; // transition to state B
            else
                next_state = 2'b00; // stay in state A
        end
        2'b01: begin // state B
            if (in)
                next_state = 2'b01; // stay in state B
            else
                next_state = 2'b10; // transition to state C
        end
        2'b10: begin // state C
            if (in)
                next_state = 2'b11; // transition to state D
            else
                next_state = 2'b00; // transition to state A
        end
        2'b11: begin // state D
            if (in)
                next_state = 2'b01; // transition to state B
            else
                next_state = 2'b10; // transition to state C
        end
    endcase
    
    if (state == 2'b11) // state D
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
