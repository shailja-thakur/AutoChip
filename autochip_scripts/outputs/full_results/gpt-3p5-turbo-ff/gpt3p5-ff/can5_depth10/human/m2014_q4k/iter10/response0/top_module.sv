module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] d;
    wire reset;

    assign reset = ~resetn;

    always @(posedge clk or negedge reset) begin
        if (~reset)
            d <= 4'b0;
        else
            d <= {in, d[3:1]};
    end
    
    assign out = d[0];

endmodule
