module top_module ();

    tff tff (
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );

    wire clk_en;
    wire reset_en;
    wire t_en;

    // Create a clock signal with a period of 10 ns.
    always @(posedge clk) begin
        clk_en <= 1;
    end

    // Create a reset signal that is asserted for 10 ns and then de-asserted.
    always @(posedge clk) begin
        if (reset) begin
            reset_en <= 1;
        end else begin
            reset_en <= 0;
        end
    end

    // Create a toggle signal that is asserted for 10 ns and then de-asserted.
    always @(posedge clk) begin
        if (t) begin
            t_en <= 1;
        end else begin
            t_en <= 0;
        end
    end

    // Observe the output of the T flip-flop.
    always @(posedge clk) begin
        $display("%d", q);
    end

endmodule