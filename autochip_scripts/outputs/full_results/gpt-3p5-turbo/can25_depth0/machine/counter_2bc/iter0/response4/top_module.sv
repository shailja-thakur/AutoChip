module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    logic [1:0] curr_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            curr_state <= 2'b01;
        end else if (train_valid) begin
            if (train_taken) begin
                if (curr_state < 2'b11) begin
                    curr_state <= curr_state + 1;
                end
            end else begin
                if (curr_state > 2'b00) begin
                    curr_state <= curr_state - 1;
                end
            end
        end
    end
    
    assign state = curr_state;
    
endmodule
