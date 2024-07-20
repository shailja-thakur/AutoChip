module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] q_int;

    sub_module u0 ( 
        .clk(clk), 
        .L(L), 
        .q_in(q_int[2]), 
        .r_in(r[2]), 
        .q_out(q[2]) 
    );
    
    sub_module u1 ( 
        .clk(clk), 
        .L(L), 
        .q_in(q_int[1]), 
        .r_in(r[1]), 
        .q_out(q[1]) 
    );
    
    sub_module u2 ( 
        .clk(clk), 
        .L(L), 
        .q_in(q_int[0]), 
        .r_in(r[0]), 
        .q_out(q[0]) 
    );

    assign q_int = q;

endmodule
module sub_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg q_out
);
    always @(posedge clk) begin
        if (L) begin
            q_out <= r_in;
        end else begin
            q_out <= q_in;
        end
    end
endmodule
