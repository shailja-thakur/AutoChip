module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

// Combinational logic for state transition and output
always @(*) begin
    case (state)
        4'b0001: // State A
            begin
                next_state = (in == 0) ? 4'b0001 : 4'b0010; // A, B
                out = 0;
            end
        4'b0010: // State B
            begin
                next_state = (in == 0) ? 4'b0100 : 4'b0010; // C, B
                out = 0;
            end
        4'b0100: // State C
            begin
                next_state = (in == 0) ? 4'b0001 : 4'b1000; // A, D
                out = 0;
            end
        4'b1000: // State D
            begin
                next_state = (in == 0) ? 4'b0100 : 4'b0010; // C, B
                out = 1;
            end
        default:
            begin
                next_state = 4'b0001; // Default to state A
                out = 0;
            end
    endcase
end

endmodule
