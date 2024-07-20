module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update state logic (toggle state on a & b high)
        if (a & b) begin
            state <= ~state;
        end
    end

    always @(posedge clk) begin
        // Update output q based on state logic
        q <= state ? ~b : b;
    end

endmodule
