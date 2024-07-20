module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] counter;

    always_ff @(posedge clk, posedge areset)
    begin
        if (areset)
            counter <= 2'b01;
        else if (train_valid)
        begin
            if (train_taken)
            begin
                if (counter < 2'b11)
                    counter <= counter + 1;
            end
            else
            begin
                if (counter > 2'b00)
                    counter <= counter - 1;
            end
        end
    end

    assign state = counter;

endmodule
