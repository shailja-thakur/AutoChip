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
            B: Y2 = 1'b0;
            C: Y2 = 1'b1; // next state E and D both have y2 = 1
            D: Y2 = 1'b1; // next state F has y2 = 1, and A has y2 = 0, since F occurs first y2 should be 1
            E: Y2 = 1'b1;
            F: Y2 = 1'b0; // next state C has y2 = 0
            default: Y2 = 1'b0; // default case should never be hit
        endcase
    end
endmodule
