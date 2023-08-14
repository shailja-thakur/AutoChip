module top_module( 
    input [99:0] in,
    output [99:0] out
);

    always @(posedge clk) begin
        for (int i = 0; i < 100; i++) begin
            out[99 - i] = in[i];
        end
    end

endmodule