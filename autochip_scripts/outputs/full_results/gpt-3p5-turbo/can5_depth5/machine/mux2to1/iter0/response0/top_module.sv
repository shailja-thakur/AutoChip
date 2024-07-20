module top_module (
    input a,
    input b,
    input sel,
    output out
);

    always @(*) begin
        if(sel)
            out = b;
        else
            out = a;
    end

endmodule
