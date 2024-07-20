module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    reg q_int;

    always @(posedge clk) begin
        if (a == 1'b1 && b == 1'b1) begin
            q_int <= ~q_int;
        end
    end

    always @(posedge clk) begin
        if (b == 1'b0) begin
            state <= 1'b0;
        end else begin
            state <= 1'b1;
        end
    end

    // Drive the outputs
    always @(posedge clk) begin
        q <= q_int;
    end

endmodule
