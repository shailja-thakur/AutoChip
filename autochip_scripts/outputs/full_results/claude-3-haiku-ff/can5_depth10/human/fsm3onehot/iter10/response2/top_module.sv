module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: // State A
            next_state = (in == 0) ? 4'b0001 : 4'b0010; // A or B
        4'b0010: // State B
            next_state = (in == 0) ? 4'b0100 : 4'b0010; // C or B
        4'b0100: // State C
            next_state = (in == 0) ? 4'b0001 : 4'b1000; // A or D
        4'b1000: // State D
            next_state = (in == 0) ? 4'b0100 : 4'b0010; // C or B
        default:
            next_state = 4'b0000; // Error state
    endcase
end

assign out = (state == 4'b1000); // Output is 1 only in state D

endmodule
