module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

// Assign statement for q
always @(*) begin
    if (a == b && c == 0 && d == e) begin
        q = b;
    end else if (a == b && c == 1 && d == e) begin
        q = e;
    end else if (a == b && c == 2 && d == e) begin
        q = a;
    end else if (a == b && c == 3 && d == e) begin
        q = d;
    end else begin
        q = 4'b1111; // Output value for all other cases
    end
end

endmodule
