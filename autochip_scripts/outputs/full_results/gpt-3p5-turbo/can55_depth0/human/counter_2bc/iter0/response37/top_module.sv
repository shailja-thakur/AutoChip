module top_module(
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01;
        else if (train_valid) begin
            if (train_taken && state != 2'b11)
                state <= state + 1;
            else if (!train_taken && state != 2'b00)
                state <= state - 1;
        end
    end
    
endmodule
