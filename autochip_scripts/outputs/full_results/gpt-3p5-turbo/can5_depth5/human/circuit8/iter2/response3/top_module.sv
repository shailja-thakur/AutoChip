module top_module (
    input wire clock,
    input wire a, 
    output reg p,
    output reg q
);

reg temp;

always @(posedge clock) begin
    if (a == 1'b0) begin
        temp <= 1'b0;  // Store 0 in temp when a is 0
    end else begin
        temp <= temp + 1'b1;  // Increment value in temp when a is 1
    end
    p <= temp;
    q <= a;
end

endmodule
