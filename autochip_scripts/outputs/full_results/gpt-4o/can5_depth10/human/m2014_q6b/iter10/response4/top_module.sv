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
        case(y)
            A: Y2 = 1'b0;
            B, C, F: Y2 = 1'b0; // All transitions in B, C, and F result in Y2 = 0
            D, E: Y2 = 1'b1;   // All transitions in D and E result in Y2 = 1
            default: Y2 = 1'b0; // default case
        endcase
    end
endmodule
