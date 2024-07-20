module top_module (
    input clk,
    input in,
    output reg out
);

    reg xor_output;
    always @ (in or out) begin
        xor_output = in ^ out;
    end
    
    always @(posedge clk) begin
        out <= xor_output;
    end

endmodule
