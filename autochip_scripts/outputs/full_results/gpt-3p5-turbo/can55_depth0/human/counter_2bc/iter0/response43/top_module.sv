module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01;
        else if (train_valid) begin
            if (train_taken && state < 2'b11)
                next_state <= state + 1;
            else if (!train_taken && state > 2'b00)
                next_state <= state - 1;
            else
                next_state <= state;
        end else
            next_state <= state;
    end
    
    always @(posedge clk) begin
        state <= next_state;
    end

endmodule
