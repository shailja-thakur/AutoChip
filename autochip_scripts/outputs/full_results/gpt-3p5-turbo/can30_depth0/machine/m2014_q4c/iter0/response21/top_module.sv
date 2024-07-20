module top_module (
    input logic clk,
    input logic d,
    input logic r,
    output logic q
);
    
    always_ff @(posedge clk) begin
        if (r)
            q <= 0;
        else
            q <= d;
    end
    
endmodule
