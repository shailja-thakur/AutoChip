module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    reg [1:0] counter;

    // Asynchronous reset
    always @(posedge areset)
    begin
        counter <= 2'b01;
    end

    // Counter logic
    always @(posedge clk)
    begin
        if (train_valid)
        begin
            if (train_taken)
                counter <= (counter == 2'b11) ? counter : counter + 1;
            else
                counter <= (counter == 2'b00) ? counter : counter - 1;
        end
    end

    // Output assignment
    assign state = counter;

endmodule
