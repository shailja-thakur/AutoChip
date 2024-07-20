module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            counter <= 2'b01;
        else if (train_valid) begin
            if (train_taken)
                counter <= (counter == 2'b11) ? 2'b11 : counter + 1;
            else
                counter <= (counter == 2'b00) ? 2'b00 : counter - 1;
        end
    end

    assign state = counter;

endmodule
