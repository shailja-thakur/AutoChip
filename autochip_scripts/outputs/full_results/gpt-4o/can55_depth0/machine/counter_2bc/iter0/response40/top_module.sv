module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State encoding
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_1;
        else if (train_valid) begin
            case (state)
                STATE_0: state <= (train_taken) ? STATE_1 : STATE_0;
                STATE_1: state <= (train_taken) ? STATE_2 : STATE_0;
                STATE_2: state <= (train_taken) ? STATE_3 : STATE_1;
                STATE_3: state <= (train_taken) ? STATE_3 : STATE_2;
                default: state <= STATE_1;
            endcase
        end
    end

endmodule
