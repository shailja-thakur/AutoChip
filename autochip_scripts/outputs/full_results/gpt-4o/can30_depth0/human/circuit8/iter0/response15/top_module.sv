module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg prev_a; // Register to store previous value of a

    always @(posedge clock) begin
        if (clock) begin
            p <= a;
        end
        else begin
            p <= p;
        end
        // Update q based on previous value of a and current p
    end

    always @(negedge clock) begin
        if (!clock) begin
            q <= prev_a;
        end
        else begin
            q <= q;
        end
        prev_a <= a; // Update prev_a at every negedge of clock
    end
endmodule
