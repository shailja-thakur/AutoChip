module top_module (
    input clk,
    input a, 
    output reg q
);

always @(posedge clk) begin
    if (a == 1) begin
        q <= ~q; // Toggle q if a is high
    end else begin
        q <= 1;  // Set q to 1 if a is low
    end
end

endmodule
