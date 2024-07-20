module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

    always @(*) begin
        // Determine the next state for y[1]
        case (y)
            6'b000001: Y1 = w;         // A to B when w=1
            6'b000010: Y1 = 1'b0;       // B to D, no transition to B directly
            6'b000100: Y1 = 1'b0;       // C to D, no transition to B directly
            6'b001000: Y1 = 1'b0;       // D to either A or D, no transition to B directly
            6'b010000: Y1 = 1'b0;       // E to D, no transition to B directly
            6'b100000: Y1 = 1'b0;       // F to either C or D, no transition to B directly
            default: Y1 = 1'b0;
        endcase
        
        // Determine the next state for y[3]
        case (y)
            6'b000001: Y3 = 1'b0;       // A to A, no transition to D directly
            6'b000010: Y3 = ~w;         // B to D when w=0
            6'b000100: Y3 = ~w;         // C to D when w=0
            6'b001000: Y3 = ~w;         // D to D when w=0
            6'b010000: Y3 = w;          // E to D when w=0
            6'b100000: Y3 = ~w;         // F to D when w=0
            default: Y3 = 1'b0;
        endcase
    end

endmodule
