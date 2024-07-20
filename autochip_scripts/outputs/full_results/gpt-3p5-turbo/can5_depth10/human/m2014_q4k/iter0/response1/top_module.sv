module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] data;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            data <= 4'b0;
        else
            data <= {in, data[3:1]};
    end
    
    assign out = data[0];
    
endmodule
