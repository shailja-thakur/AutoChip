module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg prev_a;

    always @(posedge clock) begin
        if (clock) begin
            p <= a;
        end
    end

    always @(negedge clock) begin
        if (~clock) begin
            q <= p;
        end
    end

endmodule
