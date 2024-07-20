module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // State transitions
        if (a & b) begin
            state <= 0;
        end else if (a) begin
            state <= 1;
        end

        // Output logic
        if (a & b) begin
            q <= state;
        end else if (a) begin
            q <= ~state;
        end else begin
            q <= b;
        end
    end

endmodule
