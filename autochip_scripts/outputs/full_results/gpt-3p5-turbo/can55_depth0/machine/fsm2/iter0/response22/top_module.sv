module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg [1:0] current_state, next_state;

always @(*) begin
    if (areset)
        next_state = 2'b00; // initial state A
    else if (current_state == 2'b00) begin // current state is A
        if (j)
            next_state = 2'b01; // next state B
        else
            next_state = 2'b00; // next state A
    end else begin // current state is B
        if (k)
            next_state = 2'b00; // next state A
        else
            next_state = 2'b01; // next state B
    end
end

always @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= 2'b00; // reset to state A
    else
        current_state <= next_state;
end

assign out = (current_state == 2'b01) ? 1'b1 : 1'b0;

endmodule
