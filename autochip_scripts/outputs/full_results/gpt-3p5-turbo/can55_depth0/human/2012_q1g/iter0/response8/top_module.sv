module top_module (
    input [4:1] x,
    output logic f
);

    // Intermediate signals
    logic w1, w2, w3, w4;

    // Assign intermediate signals
    assign w1 = (x[3] & x[4]);
    assign w2 = (~x[1] & ~x[2]);
    assign w3 = (x[1] & x[2]);
    assign w4 = (x[3] & ~x[4]);

    // Implement function f
    always_comb begin
        case ({x[3], x[4], x[2], x[1]})
            4'b0000: f = 1;
            4'b0001: f = 0;
            4'b0011: f = 1;
            4'b0100: f = 1;
            default: f = 0;
        endcase
    end

endmodule
