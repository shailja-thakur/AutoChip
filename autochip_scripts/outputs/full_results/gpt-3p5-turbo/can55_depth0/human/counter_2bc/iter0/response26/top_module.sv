module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    logic [1:0] counter_reg;

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            counter_reg <= 2'b01;
        else if (train_valid)
        begin
            if (train_taken && (counter_reg < 2'b11))
                counter_reg <= counter_reg + 2'b01;
            else if (!train_taken && (counter_reg > 2'b00))
                counter_reg <= counter_reg - 2'b01;
        end
    end

    assign state = counter_reg;
endmodule
