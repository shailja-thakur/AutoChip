module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Flip-flop for q
        if (a & b) begin
            q <= state;
        end else begin
            q <= ~state;
        end

        // Flip-flop for state
        if (a & b) begin
            state <= 0;
        end else if (!a & b) begin
            state <= 1;
        end else begin
            state <= state; // Hold state
        end
    end

endmodule
