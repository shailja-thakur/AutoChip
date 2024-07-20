module top_module (
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,
    input [15:0] d,
    input [15:0] e,
    input [15:0] f,
    input [15:0] g,
    input [15:0] h,
    input [15:0] i,
    input [3:0] sel,
    output logic [15:0] out
);

always_comb begin
    case (sel)
        0: out = a;
        1: out = b;
        2: out = c;
        3: out = d;
        4: out = e;
        5: out = f;
        6: out = g;
        7: out = h;
        8: out = i;
        default: out = 16'hFFFF; // Set output to all 1's for unused cases
    endcase
end

endmodule
