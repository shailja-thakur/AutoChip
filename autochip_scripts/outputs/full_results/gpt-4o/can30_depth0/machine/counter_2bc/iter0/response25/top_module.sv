module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define state encoding
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    // State register
    logic [1:0] next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1;
        end
        else begin
            if (train_valid) begin
                if (train_taken && state < S3) begin
                    next_state <= state + 1;
                end
                else if (!train_taken && state > S0) begin
                    next_state <= state - 1;
                end
                else begin
                    next_state <= state;
                end
            end
            else begin
                next_state <= state;
            end
            
            state <= next_state;
        end
    end

endmodule
