module mux2_1(
    input sel,
    input d0,
    input d1,
    output y
);
    assign y = sel ? d1 : d0;
endmodule
module d_flipflop(
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] mux_out;
    wire [2:0] ff_out;
    
    // Instantiate 3 flip-flops
    d_flipflop dff0(.clk(clk), .d(mux_out[0]), .q(ff_out[0]));
    d_flipflop dff1(.clk(clk), .d(mux_out[1]), .q(ff_out[1]));
    d_flipflop dff2(.clk(clk), .d(mux_out[2]), .q(ff_out[2]));
    
    // Instantiate 3 multiplexers
    mux2_1 mux0(.sel(L), .d0({ff_out[1] ^ ff_out[2]}), .d1(r[0]), .y(mux_out[0]));
    mux2_1 mux1(.sel(L), .d0(ff_out[0]), .d1(r[1]), .y(mux_out[1]));
    mux2_1 mux2(.sel(L), .d0(ff_out[2]), .d1(r[2]), .y(mux_out[2]));
    
    assign q = ff_out;
endmodule
