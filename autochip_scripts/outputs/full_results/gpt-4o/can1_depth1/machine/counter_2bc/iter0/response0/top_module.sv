module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // State 1
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) // Less than state 3
                    state <= state + 2'b01;
            end else begin
                if (state > 2'b00) // Greater than state 0
                    state <= state - 2'b01;
            end
        end
    end

endmodule
