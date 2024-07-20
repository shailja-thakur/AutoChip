module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State declaration
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1;  // Reset state to 1
        end else if (train_valid) begin
            case (state)
                STATE_0: begin
                    if (train_taken) state <= STATE_1;
                    else state <= STATE_0;  // Remain in current state
                end
                STATE_1: begin
                    if (train_taken) state <= STATE_2;
                    else state <= STATE_0;
                end
                STATE_2: begin
                    if (train_taken) state <= STATE_3;
                    else state <= STATE_1;
                end
                STATE_3: begin
                    if (!train_taken) state <= STATE_2;
                    else state <= STATE_3;  // Remain in current state
                end
                default: state <= STATE_1;  // Default reset state
            endcase
        end
    end

endmodule
