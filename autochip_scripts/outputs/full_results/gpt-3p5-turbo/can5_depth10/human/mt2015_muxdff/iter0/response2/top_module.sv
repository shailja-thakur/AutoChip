module flipflop(
    input clk,
    input D,
    output reg Q
    );
    
    always @(posedge clk)
        Q <= D;
        
endmodule
module mux_2to1(
    input [1:0] D,
    input sel,
    output reg Y
    );

    always @(*)
    begin
        case(sel)
            2'b00: Y = D[0];
            2'b01: Y = D[1];
            default: Y = 1'b0;
        endcase
    end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
    );

    wire [2:0] q_sub;
    wire [2:0] r_sub;
    wire L_sub;
    
    assign {q_sub[1], q_sub[0]} = q_in;
    assign {r_sub[2], r_sub[1], r_sub[0]} = r_in;
    assign L_sub = L;
    
    flipflop FF1 (
        .clk(clk),
        .D(q_sub[0]),
        .Q(q_sub[1])
        );
        
    flipflop FF2 (
        .clk(clk),
        .D(q_sub[1]),
        .Q(q_sub[2])
        );
        
    mux_2to1 M1 (
        .D({q_sub[1], q_sub[2]}),
        .sel(L_sub),
        .Y(q_sub[0])
        );
        
    mux_2to1 M2 (
        .D({q_sub[1], q_sub[2]}),
        .sel(L_sub),
        .Y(r_sub[0])
        );
        
    flipflop FF3 (
        .clk(clk),
        .D(r_sub[0]),
        .Q(Q)
        );
        
endmodule
