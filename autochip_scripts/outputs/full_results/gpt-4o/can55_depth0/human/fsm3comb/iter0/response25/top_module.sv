module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            if (in)
                next_state = 2'b01; // Transition to B
            else
                next_state = 2'b00; // Stay in A
        end
        2'b01: begin // State B
            if (in)
                next_state = 2'b01; // Stay in B
            else
                next_state = 2'b10; // Transition to C
        end
        2'b10: begin // State C
            if (in)
                next_state = 2'b11; // Transition to D
            else
                next_state = 2'b00; // Transition to A
        end
        2'b11: begin // State D
            if (in)
                next_state = 2'b01; // Transition to B
            else
                next_state = 2'b10; // Transition to C
        end
        default: next_state = 2'b00; // Default state is A
    endcase
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output logic

endmodule
