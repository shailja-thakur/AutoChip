module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg last_a; // To keep track of the previous state of a

    always @(posedge clock) begin
        if (a)
            p <= 1;
        else
            p <= 0;
    end

    always @(posedge clock or negedge clock) begin
        if (!clock) begin
            q <= p;
        end
    end

    always @(posedge clock or negedge clock) begin
        last_a <= a;
    end

endmodule
