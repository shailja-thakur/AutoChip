module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

// Define states using local parameters for clarity
localparam STATE_0 = 2'b00;
localparam STATE_1 = 2'b01;
localparam STATE_2 = 2'b10;
localparam STATE_3 = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_1; // Reset state is state 1
    end else if (train_valid) begin
        case (state)
            STATE_0: if (train_taken) state <= STATE_1;
            STATE_1: if (train_taken) state <= STATE_2; else state <= STATE_0;
            STATE_2: if (train_taken) state <= STATE_3; else state <= STATE_1;
            STATE_3: if (!train_taken) state <= STATE_2;
            default: state <= STATE_1; // Default to state 1 to handle any unexpected states
        endcase
    end
end

endmodule
