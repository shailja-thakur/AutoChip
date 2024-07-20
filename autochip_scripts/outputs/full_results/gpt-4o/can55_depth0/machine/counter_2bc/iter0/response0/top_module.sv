module top_module(
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output reg [1:0] state
);

    // State definitions
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    // State register
    reg [1:0] next_state;

    // State transition logic
    always @(*) begin
        if (areset) begin
            next_state = S1;
        end else if (train_valid) begin
            case (state)
                S0: next_state = train_taken ? S1 : S0;
                S1: next_state = train_taken ? S2 : S0;
                S2: next_state = train_taken ? S3 : S1;
                S3: next_state = train_taken ? S3 : S2;
                default: next_state = S1;
            endcase
        end else begin
            next_state = state;
        end
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1;
        end else begin
            state <= next_state;
        end
    end

endmodule
