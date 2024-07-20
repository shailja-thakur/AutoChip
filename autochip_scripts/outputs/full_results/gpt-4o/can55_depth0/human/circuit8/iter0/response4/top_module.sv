module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg was_a;

    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end

    always @(negedge clock) begin
        if (a) begin
            q <= 0;
        end else begin
            q <= was_a;
        end

        was_a <= a;
    end

endmodule
