module top_module (
    input wire a,
    input wire b,
    input wire sel_b1,
    input wire sel_b2,
    output wire out_assign,
    output reg out_always
);

    // Assign the output using an assign statement
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // Assign the output using an always block
    always @(*) begin
        if (sel_b1 && sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule
