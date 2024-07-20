module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg q_reg;
    always @(negedge clock) begin
        q_reg <= a;
    end

    always @(posedge clock or a) begin
        if (clock) begin
            p <= a;
        end
    end

    assign q = q_reg;

endmodule
