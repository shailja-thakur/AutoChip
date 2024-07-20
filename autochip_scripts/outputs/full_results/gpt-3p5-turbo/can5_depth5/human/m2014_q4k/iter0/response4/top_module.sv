module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    
    reg [3:0] d;

    always @(posedge clk or negedge resetn) begin
        if(!resetn)
            d <= 4'b0000;
        else
            d <= {d[2:0], in};
    end
    
    assign out = d[0];
    
endmodule
