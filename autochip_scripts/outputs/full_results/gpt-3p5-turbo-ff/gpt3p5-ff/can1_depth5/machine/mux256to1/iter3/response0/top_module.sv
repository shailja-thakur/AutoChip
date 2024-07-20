module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);

    reg  select_bit;
    always @(sel)
    begin
        if(sel >= 0 && sel <256)
            select_bit = in[sel];
        else
            select_bit = 1'b0;
    end

    assign out = select_bit;

endmodule
