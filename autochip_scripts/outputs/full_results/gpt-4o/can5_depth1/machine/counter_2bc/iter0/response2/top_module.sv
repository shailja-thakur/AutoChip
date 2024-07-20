module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State definitions
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1;
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < STATE_3) state <= state + 2'b01;
            end else begin
                if (state > STATE_0) state <= state - 2'b01;
            end
        end
    end

endmodule
