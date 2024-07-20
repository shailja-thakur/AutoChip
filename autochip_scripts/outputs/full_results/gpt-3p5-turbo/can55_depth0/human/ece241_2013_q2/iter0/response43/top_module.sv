module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Output out_sop in minimum sum-of-products form: (a'b'c'd') + (a'b'c'd) + (a'b'cd') + (a'b'cd) + (a'bc'd') + (a'bc'd) + (a'bcd') + (a'bcd) + (ab'c'd') + (ab'c'd) + (ab'cd') + (ab'cd) + (abc'd') + (abc'd) + (abcd') + (abcd)
    assign out_sop = ~(a & b & c & d) & ~(a & b & c & ~d) & ~(a & b & ~c & d) & ~(a & b & ~c & ~d) & ~(a & ~b & c & d) & ~(a & ~b & c & ~d) & ~(a & ~b & ~c & d) & ~(a & ~b & ~c & ~d) & ~(~a & b & c & d) & ~(~a & b & c & ~d) & ~(~a & b & ~c & d) & ~(~a & b & ~c & ~d) & ~(~a & ~b & c & d) & ~(~a & ~b & c & ~d) & ~(~a & ~b & ~c & d) & ~(~a & ~b & ~c & ~d);
    
    // Output out_pos in minimum product-of-sums form: (a+b+c+d)(a+b+c'+d)(a+b'+c+d)(a+b'+c'+d)(a'+b+c+d)(a'+b+c'+d)(a'+b'+c+d)(a'+b'+c'+d)(a'+b+c'+d)(a'+b+c'+d)(a'+b'+c+d)(a'+b'+c+d)(a+b+c'+d)(a+b+c'+d)(a+b'+c'+d)(a+b'+c'+d)
    assign out_pos = (a | b | c | d) & (a | b | ~c | d) & (a | ~b | c | d) & (a | ~b | ~c | d) & (~a | b | c | d) & (~a | b | ~c | d) & (~a | ~b | c | d) & (~a | ~b | ~c | d) & (~a | b | ~c | d) & (~a | b | ~c | d) & (~a | ~b | c | d) & (~a | ~b | c | d) & (a | b | ~c | d) & (a | b | ~c | d) & (a | ~b | ~c | d) & (a | ~b | ~c | d);

endmodule
