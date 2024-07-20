module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire [3:0] inputs;
    
    assign inputs = {a, b, c, d};

    assign out_sop = (inputs == 2'b10 || inputs == 2'b1111 || inputs == 2'b111) ? 1'b1 : 1'b0;
    assign out_pos = (inputs == 2'b00 || inputs == 2'b01 || inputs == 2'b100 || inputs == 2'b101 || inputs == 2'b110 || inputs == 2'b1001 || inputs == 2'b1010 || inputs == 2'b1101 || inputs == 2'b1110) ? 1'b0 : 1'b1;

endmodule
