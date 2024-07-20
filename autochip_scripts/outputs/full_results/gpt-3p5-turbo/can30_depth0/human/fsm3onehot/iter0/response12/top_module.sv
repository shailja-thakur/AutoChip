module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: begin // State A
            if (in)
                next_state = 4'b0010; // Next state B
            else
                next_state = 4'b0001; // Next state A
            out = 1'b0; // Output 0
        end
        
        4'b0010: begin // State B
            if (in)
                next_state = 4'b0010; // Next state B
            else
                next_state = 4'b0100; // Next state C
            out = 1'b0; // Output 0
        end
        
        4'b0100: begin // State C
            if (in)
                next_state = 4'b0001; // Next state A
            else
                next_state = 4'b1000; // Next state D
            out = 1'b0; // Output 0
        end
        
        4'b1000: begin // State D
            if (in)
                next_state = 4'b0100; // Next state C
            else
                next_state = 4'b0010; // Next state B
            out = 1'b1; // Output 1
        end
        
        default: begin
            next_state = 4'bxxxx; // Invalid state input, hold current state
            out = 1'bxxxx; // Invalid state input, hold current output
        end
    endcase
end

endmodule
