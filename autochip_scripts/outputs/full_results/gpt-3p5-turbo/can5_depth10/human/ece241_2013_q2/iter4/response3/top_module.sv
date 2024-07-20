module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

    /* Generate combinational logic for SOP form */
    always @*
    begin
        if ((a == 1 && b == 0 && c == 0 && d == 0) ||
            (a == 0 && b == 0 && c == 1 && d == 0) ||
            (a == 0 && b == 0 && c == 0 && d == 1) ||
            (a == 0 && b == 0 && c == 0 && d == 1) ||
            (a == 0 && b == 1 && c == 0 && d == 1) ||
            (a == 0 && b == 1 && c == 1 && d == 1) ||
            (a == 1 && b == 1 && c == 1 && d == 1))
        begin
            out_sop = 1;
        end
        else
        begin
            out_sop = 0;
        end
    end
    
    /* Generate combinational logic for POS form */
    always @*
    begin
        if ((a == 1 && b == 1 && c == 1 && d == 0) ||
            (a == 1 && b == 1 && c == 0 && d == 1) ||
            (a == 1 && b == 0 && c == 1 && d == 1) ||
            (a == 0 && b == 0 && c == 0 && d == 0))
        begin
            out_pos = 0;
        end
        else
        begin
            out_pos = 1;
        end
    end

endmodule
