module flipflop (
    input clk,
    input reset,
    input D,
    output reg Q
    );
    
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= D;
    end
    
endmodule
module mux_2to1 (
    input sel,
    input d0,
    input d1,
    output reg out
    );
    
    always @(*)
    begin
        if (sel)
            out <= d1;
        else
            out <= d0;
    end
    
endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
    );
    
    wire [2:0] r;
    wire q;
    
    flipflop ff1 (
        .clk(clk),
        .reset(L),
        .D(q_in),
        .Q(q)
        );
    
    mux_2to1 mux1 (
        .sel(L),
        .d0(q),
        .d1(r_in),
        .out(r[0])
        );
        
    mux_2to1 mux2 (
        .sel(L),
        .d0(r_in),
        .d1(Q),
        .out(r[1])
        );
    
    mux_2to1 mux3 (
        .sel(L),
        .d0(Q),
        .d1(q),
        .out(r[2])
        );
        
    always @(posedge clk)
    begin
        if (L)
            Q <= r_in;
        else
            Q <= {r[1] ^ r[2], r[0], r[2]};
    end
    
endmodule
