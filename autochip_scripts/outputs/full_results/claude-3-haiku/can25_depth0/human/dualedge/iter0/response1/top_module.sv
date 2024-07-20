module top_module(
    input clk,
    input d,
    output reg q
);

    reg q_reg1, q_reg2;

    // Capture the input data on both clock edges
    always @(posedge clk) begin
        q_reg1 <= d;
    end

    always @(negedge clk) begin
        q_reg2 <= d;
    end

    // Update the output based on the two registered values
    always @(*) begin
        if (clk) begin
            q <= q_reg1;
        end else begin
            q <= q_reg2;
        end
    end

endmodule
