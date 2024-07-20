module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg last_a;

    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end

        last_a <= a; // Save the value of a for use with the q output
    end

    always @(negedge clock) begin
        if (last_a) begin
            q <= 1;
        end else begin
            q <= 0;
        end
    end
endmodule
