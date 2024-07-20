module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg temp_q;

    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end
        else begin
            p <= 0;
        end

        temp_q <= p;
    end

    always @(negedge clock) begin
        q <= temp_q;
    end

endmodule
