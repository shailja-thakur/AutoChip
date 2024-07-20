module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg a_delayed;

    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
        a_delayed <= a;
    end

    always @(negedge clock) begin
        q <= a_delayed;
    end

endmodule
