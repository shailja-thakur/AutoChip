module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    reg [1:0] next_state;
    
    always @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            state <= 1;
        end else if (train_valid) begin
            if (train_taken && state < 3) begin
                next_state <= state + 1;
            end else if (!train_taken && state > 0) begin
                next_state <= state - 1;
            end else begin
                next_state <= state;
            end
        end else begin
            next_state <= state;
        end
    end
    
    always @(posedge clk) begin
        state <= next_state;
    end
endmodule
