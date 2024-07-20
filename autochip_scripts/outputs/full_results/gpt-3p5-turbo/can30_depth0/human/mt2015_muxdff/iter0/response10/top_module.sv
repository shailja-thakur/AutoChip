module flipflop (
    input clk,
    input r,
    input d,
    output reg q
);
    
    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
    
endmodule
module multiplexer_2to1 (
    input s,
    input d0,
    input d1,
    output reg q
);
    
    always @(s) begin
        if (s) begin
            q <= d1;
        end else begin
            q <= d0;
        end
    end
    
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire q_intermediate;
    
    reg q1, q2, q3;
    reg d1, d2, d3;
    
    flipflop FF1 (
        .clk(clk),
        .r(r_in),
        .d(d1),
        .q(q1)
    );
    
    flipflop FF2 (
        .clk(clk),
        .r(r_in),
        .d(d2),
        .q(q2)
    );
    
    flipflop FF3 (
        .clk(clk),
        .r(r_in),
        .d(d3),
        .q(q3)
    );
    
    multiplexer_2to1 MUX (
        .s(L),
        .d0(q2),
        .d1(q3),
        .q(q_intermediate)
    );
    
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_intermediate;
        end
    end
    
endmodule
