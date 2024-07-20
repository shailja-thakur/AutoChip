module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update state and q logic
        if (a == 1 && b == 1) begin
            state <= 1;
            q <= 0;
        end else if (a == 1 && b == 0) begin
            state <= 0;
            q <= 1;
        end else if (a == 0 && b == 1) begin
            state <= 1;
            q <= 0;
        end else begin
            state <= state;
            q <= state;
        end
    end

endmodule
