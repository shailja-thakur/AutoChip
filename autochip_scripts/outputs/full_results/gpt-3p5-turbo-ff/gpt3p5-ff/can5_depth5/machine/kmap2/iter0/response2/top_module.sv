module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire condition_1, condition_2, condition_3, condition_4; // Wires to hold the conditions

assign condition_1 = ~c & ~b; // Condition 1: c and b are both false
assign condition_2 = ~d & ~a; // Condition 2: d and a are both false
assign condition_3 = a & c & d; // Condition 3: a, c, and d are all true
assign condition_4 = b & c & d; // Condition 4: b, c, and d are all true

assign out = condition_1 | condition_2 | condition_3 | condition_4; // Output is true if any condition is true, otherwise false

endmodule
