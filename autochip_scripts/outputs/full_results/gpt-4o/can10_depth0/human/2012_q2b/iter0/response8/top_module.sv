module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);
    // State encoding
    localparam A = 6'b000001;
    localparam B = 6'b000010;
    localparam C = 6'b000100;
    localparam D = 6'b001000;
    localparam E = 6'b010000;
    localparam F = 6'b100000;

    always @(*) begin
        case (y)
            A: begin
                Y1 = w ? 1'b1 : 1'b0;  // A -> B if w=1, A -> A if w=0
                Y3 = 1'b0;  // No transition to D directly from A
            end
            B: begin
                Y1 = w ? 1'b0 : 1'b1;  // B -> C if w=1, B -> D if w=0
                Y3 = w ? 1'b0 : 1'b1;
            end
            C: begin
                Y1 = 1'b0;  // No transition to B directly from C
                Y3 = w ? 1'b0 : 1'b1;  // C -> E if w=1, C -> D if w=0
            end
            D: begin
                Y1 = 1'b0;  // No transition to B directly from D
                Y3 = w ? 1'b0 : 1'b0;  // D -> F if w=1, D -> A if w=0
            end
            E: begin
                Y1 = 1'b0;  // No transition to B directly from E
                Y3 = 1'b1;  // E -> E if w=1, E -> D if w=0
            end
            F: begin
                Y1 = w ? 1'b0 : 1'b0;  // F -> C if w=1, F -> D if w=0
                Y3 = w ? 1'b0 : 1'b1;
            end
            default: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
        endcase
    end
endmodule
