module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

// Define the state transition and output logic equations
always @(state, in)
begin
    case(state)
        4'b0001: begin
            if (in == 1'b0)
                next_state = 4'b0001; // A -> A
            else if (in == 1'b1)
                next_state = 4'b0010; // A -> B
        end
        4'b0010: begin
            if (in == 1'b0)
                next_state = 4'b0100; // B -> C
            else if (in == 1'b1)
                next_state = 4'b0010; // B -> B
        end
        4'b0100: begin
            if (in == 1'b0)
                next_state = 4'b0001; // C -> A
            else if (in == 1'b1)
                next_state = 4'b1000; // C -> D
        end
        4'b1000: begin
            if (in == 1'b0)
                next_state = 4'b0100; // D -> C
            else if (in == 1'b1)
                next_state = 4'b0010; // D -> B
        end
        default: next_state = 4'bxxxx;
    endcase
    
    // Define the output logic equation
    case(state)
        4'b0001, 4'b0010, 4'b0100: out = 1'b0; // Outputs 0 for states A, B, C
        4'b1000: out = 1'b1; // Outputs 1 for state D
        default: out = 1'bx;
    endcase
end

endmodule
