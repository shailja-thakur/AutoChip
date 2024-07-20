module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01;
        else if (train_valid) begin
            if (train_taken && (state < 2'b11))
                state <= state + 2'b01;
            else if (!train_taken && (state > 2'b00))
                state <= state - 2'b01;
        end
    end

endmodule
