module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    always @* begin
        case(state)
            2'b00: begin // Current state A
                if (in)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b00; // Next state A
            end
            2'b01: begin // Current state B
                if (in)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b10; // Next state C
            end
            2'b10: begin // Current state C
                if (in)
                    next_state = 2'b11; // Next state D
                else
                    next_state = 2'b00; // Next state A
            end
            2'b11: begin // Current state D
                if (in)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b10; // Next state C
            end
        endcase
    end

    assign out = (state == 2'b11); // Output out is high when state is D

endmodule
