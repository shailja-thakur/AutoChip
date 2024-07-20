module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // register to hold the counter value
    logic [1:0] counter;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 2'b01; // reset counter to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (counter < 2'b11) begin
                    counter <= counter + 1; // increment counter
                end
            end else begin
                if (counter > 2'b00) begin
                    counter <= counter - 1; // decrement counter
                end
            end
        end
    end

    // assign the counter value to the output
    assign state = counter;

endmodule
