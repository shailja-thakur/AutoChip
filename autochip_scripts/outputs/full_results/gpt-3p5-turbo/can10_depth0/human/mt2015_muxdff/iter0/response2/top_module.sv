module flipflop (
    input clk, 
    input rst, 
    input d, 
    output reg q
);
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
module multiplexer_2to1 (
    input a,
    input b,
    input sel,
    output reg y
);
    always @(a, b, sel)
    begin
        case(sel)
            1'b0: y = a;
            1'b1: y = b;
            default: y = 1'bx;
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
    wire q0, q1, q2, d2;
    reg [2:0] r;
    
    assign d2 = q0 ^ q2;
    assign r = r_in;
    
    flipflop ff0 (.clk(clk), .rst(L), .d(r[0]), .q(q0));
    flipflop ff1 (.clk(clk), .rst(L), .d(r[1]), .q(q1));
    flipflop ff2 (.clk(clk), .rst(L), .d(r[2]), .q(q2));
    
    multiplexer_2to1 mux0 (.a(q1), .b(q2), .sel(L), .y(Q));
    multiplexer_2to1 mux1 (.a(q0), .b(d2), .sel(L), .y(Q));
    multiplexer_2to1 mux2 (.a(q2), .b(q0), .sel(L), .y(Q));
endmodule
