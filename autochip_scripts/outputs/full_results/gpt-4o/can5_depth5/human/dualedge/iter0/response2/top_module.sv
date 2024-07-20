module top_module(
    input clk,
    input d,
    output reg q);

    reg toggle_state;

    always @(posedge clk) begin
        toggle_state <= ~toggle_state;
        if (toggle_state)
            q <= d;
    end

    always @(negedge clk) begin
        if (!toggle_state)
            q <= d;
    end
endmodule
