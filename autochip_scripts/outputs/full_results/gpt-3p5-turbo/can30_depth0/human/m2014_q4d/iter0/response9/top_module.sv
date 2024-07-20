module top_module (
    input clk,
    input in,
    output logic out
);

    logic flip_flop;
    logic xor_output;
    
    always @(posedge clk) begin
        flip_flop <= xor_output;
    end
    
    assign xor_output = in ^ out;
    
    assign out = flip_flop;
    
endmodule
