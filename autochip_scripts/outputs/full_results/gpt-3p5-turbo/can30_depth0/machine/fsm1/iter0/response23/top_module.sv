module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    wire next_state;

    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= 2'b10;  // Setting state B on reset
        else
            state <= next_state;
    end

    assign next_state = (state == 2'b10 && !in) ? 2'b01 : 2'b10;

    assign out = (state == 2'b10) ? 1'b1 : 1'b0;

endmodule
