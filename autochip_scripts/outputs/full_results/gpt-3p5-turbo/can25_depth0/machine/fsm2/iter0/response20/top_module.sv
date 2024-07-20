module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg state, next_state;

    // combinational always block to determine the next state
    always @*
    begin
        if (state == 1'b0)
            next_state = j ? 1'b1 : 1'b0;
        else
            next_state = k ? 1'b0 : 1'b1;
    end

    // clocked always block to update the state
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 1'b0;
        else
            state <= next_state;
    end

    // assign the out port
    assign out = state;

endmodule
