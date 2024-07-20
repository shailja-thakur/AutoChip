module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);
    reg prev_a;

    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end

    always @(negedge clock) begin
        prev_a <= a;
        if (!clock) begin
            q <= prev_a;
        end
    end
endmodule
