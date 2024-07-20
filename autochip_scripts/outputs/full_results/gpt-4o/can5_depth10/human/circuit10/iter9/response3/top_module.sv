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
            q <= ~state;
            state <= ~state;
        end else if (a == 1 && b == 0) begin
            q <= 1;
            state <= 0;
        end else if (a == 0 && b == 1) begin
            q <= 1;
            state <= 0;
        end else begin
            q <= state;
            state <= state;
        end
    end

endmodule
