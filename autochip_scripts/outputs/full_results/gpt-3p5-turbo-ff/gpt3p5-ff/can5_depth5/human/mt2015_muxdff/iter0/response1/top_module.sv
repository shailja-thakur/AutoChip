module flipflop(
    input clk, 
    input reset,
    input d,
    output reg q);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end
endmodule
module mux_2to1(
    input a,
    input b,
    input sel,
    output reg out);
    
    always @(*) begin
        if (sel) begin
            out <= a;
        end else begin
            out <= b;
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
    wire r1, r2, r3;
    
    flipflop ff1 (
        .clk(clk),
        .reset(0),
        .d(q1),
        .q(r1)
    );
    
    flipflop ff2 (
        .clk(clk),
        .reset(0),
        .d(q2),
        .q(r2)
    );
    
    flipflop ff3 (
        .clk(clk),
        .reset(0),
        .d(q3),
        .q(r3)
    );
    
    mux_2to1 mux1 (
        .a(r1),
        .b(r_in),
        .sel(L),
        .out(q1)
    );
    
    mux_2to1 mux2 (
        .a(r2),
        .b(r_in),
        .sel(L),
        .out(q2)
    );
    
    mux_2to1 mux3 (
        .a(r3),
        .b(r_in),
        .sel(L),
        .out(q3)
    );
    
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= {Q[1] ^ Q[2], Q[0], Q[2]};
        end
    end
    
endmodule
