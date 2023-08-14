module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);

    my_dff8 dff1 (clk, d[7:0], q[7:0]);
    my_dff8 dff2 (clk, q[7:0], q[6:0]);
    my_dff8 dff3 (clk, q[6:0], q[5:0]);

    mux4way #(8) mux (clk, sel, d[7:0], q[7:0], q[6:0], q[5:0], q[4:0], q[3:0], q[2:0], q[1:0], q[0:0]);

    output reg [7:0] y;

    always @(posedge clk) begin
        case (sel)
            2'b00: y <= d[7:0];
            2'b01: y <= q[7:0];
            2'b10: y <= q[6:0];
            2'b11: y <= q[5:0];
        endcase
    end

    assign q = mux.y;

endmodule