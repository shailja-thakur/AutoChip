module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock or negedge clock) begin
        if (clock == 0) begin
            q <= p;
        end else begin
            p <= a;
        end
    end

endmodule
