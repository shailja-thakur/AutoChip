module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    // Define state encoding for clarity
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    // State register
    reg [1:0] next_state;

    // State transition and output logic
    always @(*) begin
        if (areset) begin
            next_state = S1;
        end else if (train_valid) begin
            case (state)
                S0: next_state = train_taken ? S1 : S0;
                S1: next_state = train_taken ? S2 : S0;
                S2: next_state = train_taken ? S3 : S1;
                S3: next_state = train_taken ? S3 : S2;
                default: next_state = S1; // Default reset state
            endcase
        end else begin
            next_state = state; // Remain in the current state if not valid
        end
    end

    // Sequential part for the updating state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1;
        end else begin
            state <= next_state;
        end
    end

endmodule
