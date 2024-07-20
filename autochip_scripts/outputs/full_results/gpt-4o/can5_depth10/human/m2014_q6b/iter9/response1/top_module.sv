module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Define the states
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = 1'b0; 
            B: Y2 = w ? 1'b1 : 1'b0; // B -> D on w=1 else B -> C on w=0
            C: Y2 = 1'b1; // C -> D on w=1 else C -> E on w=0
            D: Y2 = 1'b0; // D -> A on w=1 else D -> F on w=0
            E: Y2 = 1'b0; // E always stays (E -> E) on w=0
            F: Y2 = w ? 1'b1 : 1'b0; // F -> D on w=1 else F -> C on w=0
            default: Y2 = 1'b0; // default case should never be hit
        endcase   
    end
endmodule
