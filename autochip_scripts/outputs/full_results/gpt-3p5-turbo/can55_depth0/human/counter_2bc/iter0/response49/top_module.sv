module top_module(
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);
    always_ff @(posedge clk or negedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else if (train_valid) begin
            if (train_taken) begin
                if (state == 2'b11) begin
                    state <= 2'b11;
                end else begin
                    state <= state + 2'b01;
                end
            end else begin
                if (state == 2'b00) begin
                    state <= 2'b00;
                end else begin
                    state <= state - 2'b01;
                end
            end
        end 
    end
endmodule
