module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    // Define the states for weakly taken and weakly not-taken
    localparam WEAKLY_NOT_TAKEN = 2'b01;

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            // Asynchronous reset
            state <= WEAKLY_NOT_TAKEN;
        else if (train_valid)
        begin
            if (train_taken && state < 2'b11)
                state <= state + 2'b01; // increment counter
            else if (!train_taken && state > 2'b00)
                state <= state - 2'b01; // decrement counter
        end
    end
endmodule
