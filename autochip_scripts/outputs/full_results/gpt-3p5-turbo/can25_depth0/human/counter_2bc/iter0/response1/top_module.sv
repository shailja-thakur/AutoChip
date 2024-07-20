module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else if (train_valid) begin
            if (train_taken && (state < 2)) begin
                next_state <= state + 1;
            end else if (~train_taken && (state > 0)) begin
                next_state <= state - 1;
            end else begin
                next_state <= state;
            end
        end else begin
            next_state <= state;
        end
    end
    
    always_ff @(posedge clk) begin
        state <= next_state;
    end

endmodule
