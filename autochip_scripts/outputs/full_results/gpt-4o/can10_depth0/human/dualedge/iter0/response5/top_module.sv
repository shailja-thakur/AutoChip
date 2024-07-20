module top_module(
    input clk,
    input d,
    output reg q);

    reg pos_q, neg_q;

    // Positive edge triggered flip-flop
    always @(posedge clk) begin
        pos_q <= d;
    end

    // Negative edge triggered flip-flop
    always @(negedge clk) begin
        neg_q <= d;
    end

    // Combine outputs
    always @(*) begin
        if (clk) begin
            q = pos_q;
        end else begin
            q = neg_q;
        end
    end

endmodule
