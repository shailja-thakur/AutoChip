module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Define state encoding
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    // Asynchronous reset and state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1;
        end else if (train_valid) begin
            case (state)
                STATE_0: if (train_taken) state <= STATE_1;
                STATE_1: if (train_taken) state <= STATE_2; 
                         else state <= STATE_0;
                STATE_2: if (train_taken) state <= STATE_3; 
                         else state <= STATE_1;
                STATE_3: if (!train_taken) state <= STATE_2;
                default: state <= STATE_1;
            endcase
        end
    end

endmodule
