module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end

    always @(negedge clock) begin
        if (clock == 0) begin
            q <= p;
        end
    end
endmodule
