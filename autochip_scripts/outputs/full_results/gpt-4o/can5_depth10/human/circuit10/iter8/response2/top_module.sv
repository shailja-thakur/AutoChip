module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update state logic
        if (a && b)
            state <= ~state;
        else if (a && !b)
            state <= 0;
    end

    always @(posedge clk) begin
        // Update output logic
        if (!a && b)
            q <= 1;
        else
            q <= state;
    end

endmodule
