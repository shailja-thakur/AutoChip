module top_module (
    input clk,
    input in,
    output logic out
);

    reg previous_out;

    always_ff @(posedge clk) begin
        previous_out <= out;
        out <= in ^ previous_out;
    end
    
    initial begin
        out = 0;
    end
    
endmodule
