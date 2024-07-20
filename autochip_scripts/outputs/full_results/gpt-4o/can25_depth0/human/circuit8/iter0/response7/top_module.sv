module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg state; // Internal state

    always @(posedge clock) begin
        if (a) begin
            state <= 1;
            p <= 1;
        end else begin
            state <= 0;
            p <= 0;
        end
    end

    always @(negedge clock) begin
        if (state) begin
            q <= 1;
        end else begin
            q <= 0;
        end
    end

endmodule
