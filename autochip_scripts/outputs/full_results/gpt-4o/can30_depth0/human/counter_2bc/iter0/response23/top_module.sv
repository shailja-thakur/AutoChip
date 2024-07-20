module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State definitions
    localparam [1:0] WEAKLY_NOT_TAKEN = 2'b01;
    localparam [1:0] MAX_VALUE = 2'b11;
    localparam [1:0] MIN_VALUE = 2'b00;

    // Asynchronous reset block
    always @(posedge areset or posedge clk) begin
        if (areset) begin
            state <= WEAKLY_NOT_TAKEN;
        end
        else if (train_valid) begin
            if (train_taken) begin
                if (state != MAX_VALUE) begin
                    state <= state + 1;
                end
            end else begin
                if (state != MIN_VALUE) begin
                    state <= state - 1;
                end
            end
        end
    end

endmodule
