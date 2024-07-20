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
            C: Y2 = 1'b1;
            D: Y2 = 1'b1;
            E: Y2 = w ? 1'b1 : 1'b1; // State E's Y2 is always 1, which output is exclusive effect of input w 
            F: Y2 = w ? 1'b1 : 1'b0; // state F's Y2 determination 
            default: Y2 = 1'b0; // default case should never be hit
        endcase
    end

endmodule
