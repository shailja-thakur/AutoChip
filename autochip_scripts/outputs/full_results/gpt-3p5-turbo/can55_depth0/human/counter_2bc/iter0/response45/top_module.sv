module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    reg [1:0] counter;

    always @(posedge clk or negedge areset) begin
        if (areset) begin
            counter <= 2'b01; // Weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (counter < 2'b11) begin
                    counter <= counter + 1; // Increment counter
                end
            end else begin
                if (counter > 2'b00) begin
                    counter <= counter - 1; // Decrement counter
                end
            end
        end
    end

    assign state = counter;

endmodule
