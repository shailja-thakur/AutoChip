module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(negedge clock) begin
        q <= p;
    end

    always @(posedge clock or negedge clock) begin
        if (!clock) begin
            p <= 0;
        end else if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end
endmodule
