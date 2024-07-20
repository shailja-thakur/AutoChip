module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // internal signal to store the counter value
    logic [1:0] counter;

    // asynchronous reset
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            counter <= 2'b01;
        else if (train_valid)
        begin
            if (train_taken)
            begin
                if (counter != 2'b11)
                    counter <= counter + 1;
            end
            else
            begin
                if (counter != 2'b00)
                    counter <= counter - 1;
            end
        end
    end

    // assign the counter value to the output
    assign state = counter;

endmodule
