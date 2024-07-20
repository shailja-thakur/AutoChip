module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    // Declare intermediate wires
    wire[6:1] y_next;

    // Next state logic
    always @(y) begin
        case(y)
            7'b000001: begin
                y_next = 7'b001000; // A -> B
            end
            7'b000010: begin
                y_next = 7'b000010; // A -> A
            end
            7'b000100: begin
                y_next = 7'b001100; // B -> C
            end
            7'b001000: begin
                y_next = 7'b010001; // B -> D
            end
            7'b010000: begin
                y_next = 7'b100010; // C -> E
            end
            7'b100000: begin
                y_next = 7'b010001; // C -> D
            end
            7'b001100: begin
                y_next = 7'b010100; // D -> F
            end
            7'b010001: begin
                y_next = 7'b000010; // D -> A
            end
            7'b100010: begin
                y_next = 7'b100010; // E -> E
            end
            7'b010100: begin
                y_next = 7'b010001; // E -> D
            end
            7'b001010: begin
                y_next = 7'b100010; // F -> C
            end
            7'b010101: begin
                y_next = 7'b010001; // F -> D
            end
            default: begin
                y_next = 7'b000001; // Default state is A
            end
        endcase
    end

    // Output logic
    always @(posedge w) begin
        Y2 <= y_next[2];
        Y4 <= y_next[4];
    end
    
endmodule
