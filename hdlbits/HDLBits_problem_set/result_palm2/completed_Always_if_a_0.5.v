module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 

    // Assign statement implementation
    out_assign = (sel_b1 & sel_b2) ? b : a;

    // Procedural if statement implementation
    always @(sel_b1 or sel_b2 or a or b) begin
        if (sel_b1 & sel_b2) begin
            out_always = b;
        end else begin
            out_always = a;
        end
    end

endmodule