module top_module( 
    input [7:0] in,
    output [7:0] out
);

    always @(posedge clk) begin
        out <= {in[6], in[5], in[4], in[3], in[2], in[1], in[0], in[7]};
    end

endmodule