module flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk)
        Q <= D;
endmodule
module mux(
    input sel,
    input D0,
    input D1,
    output reg Y
);
    always @*
    begin
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
    wire [2:0] r;
    wire [2:0] q;
    
    wire d0, d1;
    wire sel;
    
    flipflop ff1(
        .clk(clk),
        .D(d0),
        .Q(q[0])
    );
    
    flipflop ff2(
        .clk(clk),
        .D(d1),
        .Q(q[1])
    );
    
    flipflop ff3(
        .clk(clk),
        .D(sel),
        .Q(q[2])
    );
    
    mux mux1(
        .sel(L),
        .D0(r_in),
        .D1(q_in),
        .Y(d0)
    );
    
    mux mux2(
        .sel(q[1] ^ q[2]),
        .D0(q[0]),
        .D1(q[2]),
        .Y(d1)
    );
    
    assign Q = q[2];
endmodule
