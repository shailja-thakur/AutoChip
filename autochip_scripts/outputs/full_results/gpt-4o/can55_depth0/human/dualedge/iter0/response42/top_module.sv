module top_module(
    input clk,
    input d,
    output reg q);

    reg q_pos, q_neg;

    // Capture data on each clock edge by using two separate always blocks
    always @(posedge clk) begin
        q_pos <= d;
    end

    always @(negedge clk) begin
        q_neg <= d;
    end

    // Use a mux to select the appropriate value depending on the clock edge
    always @(*) begin
        if (clk)
            q = q_pos;
        else
            q = q_neg;
    end
endmodule
