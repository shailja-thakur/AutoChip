module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock or posedge a) begin
        if (a == 1) begin
            p <= 1;
        end else if (clock) begin
            p <= 0;
        end
    end

    always @(negedge clock) begin
        q <= p;
    end

endmodule
