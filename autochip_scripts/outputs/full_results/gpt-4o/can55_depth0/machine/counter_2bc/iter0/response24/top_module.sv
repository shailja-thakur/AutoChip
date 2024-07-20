module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State definition
    localparam STATE_0 = 2'd0;
    localparam STATE_1 = 2'd1;
    localparam STATE_2 = 2'd2;
    localparam STATE_3 = 2'd3;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1;
        end else if (train_valid) begin
            case (state)
                STATE_0: if (train_taken) state <= STATE_1;
                STATE_1: if (train_taken) state <= STATE_2;
                         else             state <= STATE_0;
                STATE_2: if (train_taken) state <= STATE_3;
                         else             state <= STATE_1;
                STATE_3: if (!train_taken) state <= STATE_2;
            endcase
        end
    end

endmodule
