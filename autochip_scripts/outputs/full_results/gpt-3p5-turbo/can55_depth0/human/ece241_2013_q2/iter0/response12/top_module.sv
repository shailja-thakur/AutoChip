module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    reg out_sop_reg;
    wire out_pos_wire;

    // Logic for out_sop
    always @* begin
        if (a==0 && b==0 && c==1 && d==0) begin
            out_sop_reg = 1'b1;
        end else if (a==0 && b==1 && c==1 && d==1) begin
            out_sop_reg = 1'b1;
        end else if (a==1 && b==1 && c==1 && d==1) begin
            out_sop_reg = 1'b1;
        end else begin
            out_sop_reg = 1'b0;
        end
    end

    // Logic for out_pos
    assign out_pos_wire = (~a & ~b & ~c & ~d) |
                         (~a & b & ~c & ~d) |
                         (~a & b & c & ~d) |
                         (~a & b & c & d) |
                         (a & b & c & d) |
                         (~a & b & ~c & d) |
                         (~a & ~b & c & d) |
                         (a & ~b & ~c & d) |
                         (a & ~b & c & d);

    // Output assignments
    assign out_sop = out_sop_reg;
    assign out_pos = out_pos_wire;

endmodule
