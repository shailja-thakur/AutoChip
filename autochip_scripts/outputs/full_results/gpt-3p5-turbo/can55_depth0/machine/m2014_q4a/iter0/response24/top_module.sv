module top_module (
    input d,
    input ena,
    output logic q
);
assign q = ena ? d : q;
endmodule
