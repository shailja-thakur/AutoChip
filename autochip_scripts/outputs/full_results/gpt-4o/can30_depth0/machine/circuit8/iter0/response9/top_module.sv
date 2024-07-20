module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(negedge clock) begin
        q <= a;
    end

    always @(a or posedge clock) begin
        if (clock) begin
            p <= a;
        end
    end

endmodule
