module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01;  // reset state to 01
    end else if (train_valid) begin
        case (state)
            2'b00: if (train_taken) state <= 2'b01; // transition to next state if taken
            2'b01: if (!train_taken) state <= 2'b00; // transition to previous state if not taken
            2'b10: if (train_taken) state <= 2'b11; // transition to next state if taken
            2'b11: if (!train_taken) state <= 2'b10; // transition to previous state if not taken
        endcase
    end
end

endmodule
