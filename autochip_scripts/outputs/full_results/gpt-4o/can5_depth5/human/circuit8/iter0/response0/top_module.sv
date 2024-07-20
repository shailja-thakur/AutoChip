module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg prev_a;

    always @(posedge clock) begin
        prev_a <= a;
        if (a && !prev_a) begin
            p <= 1;
            q <= 0;
        end
        else begin
            p <= 0;
        end
    end

    always @(negedge clock) begin
        if (p) begin
            q <= 1;
        end
        else begin
            q <= 0;
        end
    end

endmodule
