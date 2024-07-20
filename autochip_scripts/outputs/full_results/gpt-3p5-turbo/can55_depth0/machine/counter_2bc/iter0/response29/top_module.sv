module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define states
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    // State register
    logic [1:0] current_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end else begin
            if (train_valid) begin
                if (train_taken && current_state < S3) begin
                    current_state <= current_state + 1;
                end else if (!train_taken && current_state > S0) begin
                    current_state <= current_state - 1;
                end
            end
        end
    end

    assign state = current_state;

endmodule
