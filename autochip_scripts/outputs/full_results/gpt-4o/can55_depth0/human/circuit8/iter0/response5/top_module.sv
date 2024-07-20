module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock) begin
        // Output p should follow the input a
        p <= a;
    end

    always @(negedge clock) begin
        // Output q should follow output p from the last positive edge
        q <= p;
    end

endmodule
