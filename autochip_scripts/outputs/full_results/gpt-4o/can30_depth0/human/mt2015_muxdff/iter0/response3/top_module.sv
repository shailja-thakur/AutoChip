module mux2to1(
    input d0,
    input d1,
    input sel,
    output reg y
);
    always @(*) begin
        if (sel)
            y = d1;
        else
            y = d0;
    end
endmodule
module d_flip_flop(
    input d,
    input clk,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] mux_out;

    // Instantiating 3 flip-flops and 3 multiplexers
    genvar i;
    generate
        for (i = 0; i < 3; i = i + 1) begin: gen_block
            mux2to1 U_mux(
                .d0((i == 0) ? q[2] : ((i == 1) ? q[0] : (q[1] ^ q[2]))), // Select the appropriate bits for the XOR operation
                .d1(r[i]),
                .sel(L),
                .y(mux_out[i])
            );

            d_flip_flop U_dff(
                .d(mux_out[i]),
                .clk(clk),
                .q(q[i])
            );
        end
    endgenerate
endmodule
