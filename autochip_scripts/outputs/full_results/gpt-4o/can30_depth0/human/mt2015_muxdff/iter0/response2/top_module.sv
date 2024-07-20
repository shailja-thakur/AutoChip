module flipflop_mux (
    input wire clk,
    input wire L,
    input wire d,
    input wire sel,
    output reg q
);
    always @(posedge clk) begin
        if (sel) begin
            q <= d;
        end else begin
            q <= sel ^ d;
        end
    end
endmodule
module top_module (
    input wire [2:0] r,
    input wire L,
    input wire clk,
    output reg [2:0] q
);
    wire [2:0] q_internal;

    // Instantiate flipflop_mux three times
    flipflop_mux u0 (
        .clk(clk),
        .L(L),
        .d(r[0]),
        .sel(L),
        .q(q_internal[0])
    );

    flipflop_mux u1 (
        .clk(clk),
        .L(L),
        .d(r[1]),
        .sel(L),
        .q(q_internal[1])
    );

    flipflop_mux u2 (
        .clk(clk),
        .L(L),
        .d(r[2]),
        .sel(L),
        .q(q_internal[2])
    );

    // Assign the internal q to output
    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= q_internal;
        end
    end
endmodule
