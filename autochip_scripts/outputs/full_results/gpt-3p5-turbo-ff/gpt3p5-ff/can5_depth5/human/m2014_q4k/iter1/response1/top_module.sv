module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    
    reg [3:0] data;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            data <= 4'b0000;
        else
            data <= {data[2:0], in};
    end
    
    assign out = data[3];
    
endmodule
