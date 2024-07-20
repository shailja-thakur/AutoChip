module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // States
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1;
        end else if (train_valid) begin
            case (state)
                S0: state <= train_taken ? S1 : S0;
                S1: state <= train_taken ? S2 : (train_valid && !train_taken ? S0 : S1);
                S2: state <= train_taken ? S3 : (train_valid && !train_taken ? S1 : S2);
                S3: state <= train_taken ? S3 : (train_valid && !train_taken ? S2 : S3);
                default: state <= S1;
            endcase
        end
    end

endmodule
