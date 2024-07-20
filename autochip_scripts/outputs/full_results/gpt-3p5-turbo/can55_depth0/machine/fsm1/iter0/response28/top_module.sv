module top_module (
    input wire clk,
    input wire in,
    input wire areset,
    output wire out
);

    reg state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1'b0;
        else
            state <= next_state;
    end

    always @* begin
        if (state == 1'b0)
            next_state = in ? 1'b0 : 1'b1;
        else
            next_state = in ? 1'b1 : 1'b0;
    end

    assign out = (state == 1'b1) ? 1'b1 : 1'b0;

endmodule
