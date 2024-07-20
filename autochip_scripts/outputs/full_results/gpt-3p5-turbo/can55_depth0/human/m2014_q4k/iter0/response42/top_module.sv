module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    
    reg [3:0] d; // D flops
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            d <= 4'b0; // synchronous reset
        end else begin
            d <= {d[2:0], in}; // shift operation
        end
    end

    assign out = d[3]; // output

endmodule
