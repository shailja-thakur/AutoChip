module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg [1:0] state;

    always @(posedge clock) begin
        if (a) begin
            p <= 1;
            q <= q;
        end else begin
            p <= 0;
            q <= p;
        end
    end

endmodule
