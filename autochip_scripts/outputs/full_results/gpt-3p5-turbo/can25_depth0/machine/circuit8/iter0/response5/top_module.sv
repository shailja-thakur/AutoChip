module top_module (
        input clock,
        input a,
        output reg p,
        output reg q
    );
    reg a_delayed;

    always @(negedge clock) begin
        q <= a;
    end

    always @(posedge clock or a) begin
        if (clock) begin
            p <= a;
        end
    end
endmodule
