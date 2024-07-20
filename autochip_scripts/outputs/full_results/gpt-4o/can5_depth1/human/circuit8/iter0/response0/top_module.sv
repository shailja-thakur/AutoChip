module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg prev_a; // To store the previous value of a

    always @(posedge clock or negedge clock) begin
        if (clock) begin
            if (a) begin
                p <= 1;
            end else begin
                p <= 0;
            end
        end
    end

    always @(posedge clock) begin
        if (~clock) begin
            if (prev_a == 1 && a == 0) begin
                q <= 1;
            end else begin
                q <= 0;
            end
        end
    end

    always @(posedge clock or negedge clock) begin
        prev_a <= a;
    end

endmodule
