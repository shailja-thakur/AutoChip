module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] d_ff;
    
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            d_ff <= 4'b0000;
        else
            d_ff <= {d_ff[2:0], in};
    end

    assign out = d_ff[0];

endmodule
