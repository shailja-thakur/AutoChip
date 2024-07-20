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
            A: Y2 = 1'b0; // A state Y2 = 0
            B: Y2 = 1'b0; // B state Y2 depends but is set to 0 here as intermediate Y value
            C: Y2 = 1'b0; // C state Y2 depends but is set to 0 here as intermediate Y value
            D: Y2 = 1'b0; // D state always goes to 0 or 1 so intermediate Y
            E: Y2 = 1'b1; // E state Y2 = 1
            F: Y2 = 1'b1; // F state Y2 depends but goes to 1 here as intermediate Y value
            default: Y2 = 1'b0; // should not reach here
        endcase   
    end
endmodule
