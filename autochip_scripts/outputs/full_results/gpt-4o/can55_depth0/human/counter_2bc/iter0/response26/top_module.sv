module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

reg [1:0] counter;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter <= 2'b01; // Weakly not-taken
    end else if (train_valid) begin
        if (train_taken) begin
            if (counter < 2'b11) begin
                counter <= counter + 2'b01;
            end
        end else begin
            if (counter > 2'b00) begin
                counter <= counter - 2'b01;
            end
        end
    end
    // No need to handle the non-training case (train_valid == 0) as the counter remains unchanged.
end

assign state = counter;

endmodule
