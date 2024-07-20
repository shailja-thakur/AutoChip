module top_module (
    input in,
    input [3:0] state,
    output wire [3:0] next_state,
    output wire out
);

// FSM state encoding
parameter A = 4'b0001;
parameter B = 4'b0010;
parameter C = 4'b0100;
parameter D = 4'b1000;

always @(*) begin
    case(state)
        A: begin // State A
            if (in == 1'b0)
                next_state = A; // Next state is A
            else if (in == 1'b1)
                next_state = B; // Next state is B
        end
        B: begin // State B
            if (in == 1'b0)
                next_state = C; // Next state is C
            else if (in == 1'b1)
                next_state = B; // Next state is B
        end
        C: begin // State C
            if (in == 1'b0)
                next_state = A; // Next state is A
            else if (in == 1'b1)
                next_state = D; // Next state is D
        end
        D: begin // State D
            if (in == 1'b0)
                next_state = C; // Next state is C
            else if (in == 1'b1)
                next_state = B; // Next state is B
        end
        default:
            next_state = 4'bxxxx; // Default value for next_state
    endcase
    
    case(state)
        A, B, C: out = 1'b0; // Output is 0 in states A, B, and C
        D: out = 1'b1; // Output is 1 in state D
        default: out = 1'bx; // Default value for out
    endcase
end

endmodule
