module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @(state or in) begin
        case(state)
            4'b0001: begin
                if (in)
                    next_state = 4'b0010; // B
                else
                    next_state = 4'b0001; // A
                out = 1'b0; // Output for state A
            end
            4'b0010: begin
                if (in)
                    next_state = 4'b0100; // C
                else
                    next_state = 4'b0010; // B
                out = 1'b0; // Output for state B
            end
            4'b0100: begin
                if (in)
                    next_state = 4'b1000; // D
                else
                    next_state = 4'b0001; // A
                out = 1'b0; // Output for state C
            end
            4'b1000: begin
                if (in)
                    next_state = 4'b0010; // B
                else
                    next_state = 4'b0100; // C
                out = 1'b1; // Output for state D
            end
            default: begin
                next_state = 4'bxxxx; // Unknown state, set next state as xxxx
                out = 1'bx; // Unknown output, set as x
            end
        endcase
    end
endmodule
