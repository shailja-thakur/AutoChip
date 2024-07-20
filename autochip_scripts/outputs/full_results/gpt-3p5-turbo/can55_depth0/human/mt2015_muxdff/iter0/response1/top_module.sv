module flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module mux_2to1(
    input sel,
    input D0,
    input D1,
    output reg Y
);
    always @(sel) begin
        if (sel)
            Y <= D1;
        else
            Y <= D0;
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire sel;
    wire [2:0] r, q;
    
    flipflop ff (
        .clk(clk),
        .D(q_in),
        .Q(Q)
    );
    
    mux_2to1 mux (
        .sel(sel),
        .D0(q[1] ^ q[2]),
        .D1(q[0] ^ q[2]),
        .Y(r)
    );
    
    always @(posedge clk) begin
        if (L) begin
            q <= r_in;
        end else begin
            q <= r;
        end
    end
    
    assign sel = L;
endmodule
