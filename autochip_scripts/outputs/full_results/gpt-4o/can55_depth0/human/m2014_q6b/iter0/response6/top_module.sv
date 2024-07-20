module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A
            3'b001: Y2 = w;    // State B -> 0 if w=0, 0 if w=1
            3'b010: Y2 = 1'b0; // State C
            3'b011: Y2 = ~w;   // State D -> 0 if w=0, 1 if w=1
            3'b100: Y2 = 1'b0; // State E (though Y2 genuinely doesn't change for state E since it's considered the next-state logic
            3'b101: Y2 = w;    // State F (though Y2 genuinely doesn't change for state F since it's considered the next-state logic
            default: Y2 = 1'b0; // Default case
        endcase
    end

endmodule
