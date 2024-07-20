module mux2to1 (
    input wire sel,
    input wire a,
    input wire b,
    output wire y
);
    assign y = sel ? b : a;
endmodule
module dff (
    input wire clk,
    input wire d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module top_module (
    input wire clk,
    input wire L,
    input wire [2:0] r,
    output wire [2:0] q
);

    wire [2:0] d;

    // Instantiate mux2to1 and dff for each bit
    generate
        genvar i;
        for (i = 0; i < 3; i = i + 1) begin : BIT_SLICE
            wire mux_out;
            wire dff_out;

            mux2to1 u_mux (
                .sel(L),
                .a(q[i]),
                .b(r[i]),
                .y(mux_out)
            );

            dff u_dff (
                .clk(clk),
                .d(mux_out),
                .q(dff_out)
            );

            assign d[i] = (i == 0) ? dff_out : (i == 1) ? dff_out ^ d[2] : dff_out;
        end
    endgenerate

    assign q = d;

endmodule
