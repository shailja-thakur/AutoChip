module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01;
    else if (train_valid && train_taken) begin
        if (state == 2'b11)
            state <= 2'b11;
        else
            state <= state + 1;
    end else if (train_valid && !train_taken) begin
        if (state == 2'b00)
            state <= 2'b00;
        else
            state <= state - 1;
    end
end

endmodule
