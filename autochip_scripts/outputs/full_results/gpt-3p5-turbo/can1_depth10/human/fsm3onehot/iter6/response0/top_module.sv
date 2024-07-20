module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

always @(*) begin
    case(state)
        4'b0001: begin // State A
            if (in == 1'b0)
                next_state = 4'b0001; // Next state is A
            else if (in == 1'b1)
                next_state = 4'b0010; // Next state is B
        end
        4'b0010: begin // State B
            if (in == 1'b0)
                next_state = 4'b0100; // Next state is C
            else if (in == 1'b1)
                next_state = 4'b0010; // Next state is B
        end
        4'b0100: begin // State C
            if (in == 1'b0)
                next_state = 4'b0001; // Next state is A
            else if (in == 1'b1)
                next_state = 4'b1000; // Next state is D
        end
        4'b1000: begin // State D
            if (in == 1'b0)
                next_state = 4'b0100; // Next state is C
            else if (in == 1'b1)
                next_state = 4'b0010; // Next state is B
        end
        default:
            next_state = 4'bxxxx; // Default value for next_state
    endcase
    
    case(state)
        4'b0001: out = 1'b0; // Output is 0 in state A
        4'b0010: out = 1'b0; // Output is 0 in state B
        4'b0100: out = 1'b0; // Output is 0 in state C
        4'b1000: out = 1'b1; // Output is 1 in state D
        default: out = 1'bx; // Default value for out
    endcase
end

endmodule
