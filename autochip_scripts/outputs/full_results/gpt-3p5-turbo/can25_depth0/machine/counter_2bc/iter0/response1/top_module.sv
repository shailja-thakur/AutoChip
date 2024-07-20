module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    reg [1:0] state_reg;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state_reg <= 2'b01;
        else if (train_valid) begin
            if (train_taken && (state_reg < 2'b11))
                state_reg <= state_reg + 1;
            else if (!train_taken && (state_reg > 2'b00))
                state_reg <= state_reg - 1;
        end
    end

    assign state = state_reg;

endmodule
