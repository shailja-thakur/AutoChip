module top_module (
    input [4:1] x,
    output logic f
);

// Implementation of the function f using if-else statements
always_comb begin
    if (x == 4'b0110 || x == 4'b1001) begin
        f = 0;
    end else if (x == 4'b0101 || x == 4'b1000) begin
        f = 1;
    end else begin
        f = x[3];
    end
end

endmodule
