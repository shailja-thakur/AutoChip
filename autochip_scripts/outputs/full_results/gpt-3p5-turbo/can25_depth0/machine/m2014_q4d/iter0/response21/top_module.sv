module top_module (
    input clk,
    input in,
    output logic out
);
    
    logic prev_out;
    
    always_ff @(posedge clk)
        prev_out <= out;
    
    assign out = in ^ prev_out;
    
endmodule
