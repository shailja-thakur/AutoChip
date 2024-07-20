module flipflop(
    input clk,
    input D,
    output reg Q);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule
module mux_2to1(
    input S,
    input [1:0] D,
    output reg Q);

    always @(S or D) begin
        if (S == 0) begin
            Q <= D[0];
        end else begin
            Q <= D[1];
        end
    end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    wire q1, q2, q3;
    wire mux_out1, mux_out2, mux_out3;
    wire d1, d2, d3;
    
    flipflop ff1 (
        .clk(clk),
        .D(d1),
        .Q(q1)
    );
    
    flipflop ff2 (
        .clk(clk),
        .D(d2),
        .Q(q2)
    );
    
    flipflop ff3 (
        .clk(clk),
        .D(d3),
        .Q(q3)
    );
    
    mux_2to1 mux1 (
        .S(r_in),
        .D({q1, q2}),
        .Q(mux_out1)
    );
    
    mux_2to1 mux2 (
        .S(L),
        .D({q3, mux_out1}),
        .Q(mux_out2)
    );
    
    mux_2to1 mux3 (
        .S(L),
        .D({q_in, mux_out1}),
        .Q(mux_out3)
    );
    
    always @(posedge clk) begin
        if (L) begin
            d1 <= r_in;
        end else begin
            d1 <= mux_out3;
        end
        
        if (L) begin
            d2 <= q2;
        end else begin
            d2 <= q3;
        end
        
        if (L) begin
            d3 <= q3;
        end else begin
            d3 <= {mux_out2, q3};
        end
        
        Q <= q1;
    end

endmodule
