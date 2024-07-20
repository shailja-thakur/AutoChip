module top_module (
    input [4:1] x,
    output logic f
);

// Implement the function f based on the Karnaugh map
// x[3:1] represent the inputs x[3], x[2], x[1], and x[4] represents the fourth input

always_comb begin
    case ({x[3], x[2], x[1]})
        3'b001: f = 1'b0;
        3'b011: f = 1'b1;
        3'b101: f = 1'b1;
        3'b110: f = 1'b1;
        default: f = 1'b0; // Output 0 for don't-care conditions
    endcase
end

endmodule
