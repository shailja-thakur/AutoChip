module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);
    always @(*) begin
        // Determine Y1 (the input of state flip-flop y[1], which represents state B)
        case (y)
            6'b000001: Y1 = w;                      // from state A: A --1--> B
            default: Y1 = 1'b0;                      // Default to 0 for all other cases
        endcase
        
        // Determine Y3 (the input of state flip-flop y[3], which represents state D)
        case (y)
            6'b000010: Y3 = ~w;                     // from state B: B --0--> D
            6'b000100: Y3 = ~w;                     // from state C: C --0--> D
            6'b010000: Y3 = ~w;                     // from state E: E --0--> D
            6'b100000: Y3 = ~w;                     // from state F: F --0--> D
            default: Y3 = 1'b0;                      // Default to 0 for all other cases
        endcase
    end
endmodule
