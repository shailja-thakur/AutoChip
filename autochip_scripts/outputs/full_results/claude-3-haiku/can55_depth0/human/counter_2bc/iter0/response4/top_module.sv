module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset)
        state <= 2'b01;
    else if (train_valid) begin
        if (train_taken)
            state <= (state == 2'b11) ? 2'b11 : state + 1'b1; // Saturate at 3
        else
            state <= (state == 2'b00) ? 2'b00 : state - 1'b1; // Saturate at 0
    end
end

endmodule
