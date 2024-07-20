module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    // State declaration
    reg state;

    // Initial state
    initial begin
        p = 0;
        q = 0;
        state = 0;
    end

    // Sequential logic
    always @(posedge clock or negedge clock) begin
        if (!clock) begin
            if (a == 1'b1) begin
                state <= 1'b1;
            end
        end else if (clock) begin
            if (state == 1'b1) begin
                p <= 1'b1;
            end else if (state == 1'b0) begin
                p <= 1'b0;
            end
            q <= state;
        end
    end
endmodule
