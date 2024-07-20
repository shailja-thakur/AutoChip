module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    wire ab_or;
    wire cd_or;
    
    or #(1) u1 (
        .a(a),
        .b(b),
        .y(ab_or)
    );
    
    or #(1) u2 (
        .a(c),
        .b(d),
        .y(cd_or)
    );
    
    and #(1) u3 (
        .a(ab_or),
        .b(cd_or),
        .y(q)
    );
endmodule
