module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    // State encoding
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1; // Reset to state 1
        end else if (train_valid) begin
            case (state)
                S0: state <= (train_taken) ? S1 : S0;
                S1: state <= (train_taken) ? S2 : S0;
                S2: state <= (train_taken) ? S3 : S1;
                S3: state <= (train_taken) ? S3 : S2;
                default: state <= S1; // Default case to handle unexpected states
            endcase
        end
    end
endmodule
