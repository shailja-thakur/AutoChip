module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg prev_a;

    always @(posedge clock) begin
        prev_a <= a;
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end

    always @(negedge clock) begin
        if (!prev_a && a) begin
            q <= 0;
        end else begin
            q <= p;
        end
    end
endmodule
