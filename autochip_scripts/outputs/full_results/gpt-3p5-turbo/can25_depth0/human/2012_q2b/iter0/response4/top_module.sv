module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Define the state flip-flops
reg [5:0] y_reg;

// Assign the outputs based on the state values
assign Y1 = y_reg[1];
assign Y3 = y_reg[3];

// Sequential logic for state transition using a case statement
always @(posedge w) begin
    case (y_reg)
        // A (0) --1--> B
        // A (0) --0--> A
        6'b000001: y_reg <= w ? 6'b000010 : 6'b000001;
        
        // B (0) --1--> C
        // B (0) --0--> D
        6'b000010: y_reg <= w ? 6'b000100 : 6'b001000;
        
        // C (0) --1--> E
        // C (0) --0--> D
        6'b000100: y_reg <= w ? 6'b010000 : 6'b001000;
        
        // D (0) --1--> F
        // D (0) --0--> A
        6'b001000: y_reg <= w ? 6'b100000 : 6'b000001;
        
        // E (1) --1--> E
        // E (1) --0--> D
        6'b010000: y_reg <= w ? 6'b010000 : 6'b001000;
        
        // F (1) --1--> C
        // F (1) --0--> D
        6'b100000: y_reg <= w ? 6'b000100 : 6'b001000;
    endcase
end

endmodule
