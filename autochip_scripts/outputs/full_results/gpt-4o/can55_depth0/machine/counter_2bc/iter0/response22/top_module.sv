module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Define states
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    parameter STATE_2 = 2'b10;
    parameter STATE_3 = 2'b11;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1;
        end else if (train_valid) begin
            case (state)
                STATE_0: if (train_taken) state <= STATE_1;
                STATE_1: state <= (train_taken) ? STATE_2 : STATE_0;
                STATE_2: state <= (train_taken) ? STATE_3 : STATE_1;
                STATE_3: if (!train_taken) state <= STATE_2;
                default: state <= STATE_1; // Default state
            endcase
        end
    end

endmodule
