module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [1:0] ab;
wire [1:0] cd;

assign ab = {c, d};
assign cd = {c, d};

// 4-to-1 MUX
wire [3:0] mux_out;
assign mux_out[0] = (~ab[1] & ~ab[0] & ~cd[1] & ~cd[0]) | 
                    (~ab[1] & ab[0] & ~cd[1] & ~cd[0]) |
                    (ab[1] & ~ab[0] & ~cd[1] & ~cd[0]) |
                    (ab[1] & ab[0] & cd[1] & ~cd[0]);

assign mux_out[1] = (ab[1] & ~ab[0] & ~cd[1] & ~cd[0]) | 
                    (ab[1] & ~ab[0] & cd[1] & ~cd[0]) |
                    (ab[1] & ab[0] & ~cd[1] & ~cd[0]) |
                    (~ab[1] & ab[0] & cd[1] & ~cd[0]);

assign mux_out[2] = (ab[1] & ab[0] & ~cd[1] & ~cd[0]) | 
                    (~ab[1] & ~ab[0] & cd[1] & ~cd[0]) |
                    (~ab[1] & ab[0] & cd[1] & ~cd[0]) |
                    (~ab[1] & ~ab[0] & ~cd[1] & cd[0]);

assign mux_out[3] = (~ab[1] & ab[0] & ~cd[1] & ~cd[0]) | 
                    (~ab[1] & ab[0] & cd[1] & cd[0]) |
                    (~ab[1] & ~ab[0] & ~cd[1] & cd[0]) |
                    (~ab[1] & ~ab[0] & cd[1] & cd[0]);

// 2-to-1 MUX
wire [3:0] mux_out_2;
wire a;
wire b;

assign a = ab[1];
assign b = ab[0];

assign mux_out_2[0] = (~a & ~b & mux_out[0]) | (a & ~b & mux_out[1]);
assign mux_out_2[1] = (~a & ~b & mux_out[2]) | (a & ~b & mux_out[3]);

assign mux_in[0] = (~a & b & mux_out_0) | (a & b & mux_out_1);
assign mux_in[1] = (~a & ~b & mux_out_0) | (a & ~b & mux_out_1);
assign mux_in[2] = (~a & ~b & mux_out_2[0]) | (a & ~b & mux_out_2[1]);
assign mux_in[3] = (~a & b & mux_out_2[0]) | (a & b & mux_out_2[1]);

endmodule
