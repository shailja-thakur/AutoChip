module mux2to1(
    input sel,
    input d0,
    input d1,
    output y
);
    assign y = (sel) ? d1 : d0;
endmodule
module d_flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] mux_out;
    
    mux2to1 mux_0(.sel(L), .d0(q[1] ^ q[2]), .d1(r[0]), .y(mux_out[0]));
    mux2to1 mux_1(.sel(L), .d0(q[0]), .d1(r[1]), .y(mux_out[1]));
    mux2to1 mux_2(.sel(L), .d0(q[2]), .d1(r[2]), .y(mux_out[2]));
    
    d_flipflop dff_0(.clk(clk), .D(mux_out[0]), .Q(q[0]));
    d_flipflop dff_1(.clk(clk), .D(mux_out[1]), .Q(q[1]));
    d_flipflop dff_2(.clk(clk), .D(mux_out[2]), .Q(q[2])); 
endmodule
