module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] next_state;
    
    always_ff @(posedge clk or negedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else begin
            case (state)
                2'b00: begin
                    if (train_taken) begin
                        next_state <= 2'b01;
                    end else begin
                        next_state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (train_valid && train_taken && state < 2'b11) begin
                        next_state <= state + 1;
                    end else if (train_valid && !train_taken && state > 2'b00) begin
                        next_state <= state - 1;
                    end else begin
                        next_state <= state;
                    end
                end
                2'b10: begin
                    if (train_valid && train_taken && state < 2'b11) begin
                        next_state <= state + 1;
                    end else if (train_valid && !train_taken && state > 2'b00) begin
                        next_state <= state - 1;
                    end else begin
                        next_state <= state;
                    end
                end
                2'b11: begin
                    if (train_valid && !train_taken && state > 2'b00) begin
                        next_state <= state - 1;
                    end else begin
                        next_state <= state;
                    end
                end
                default: next_state <= state;
            endcase
        end
    end
    
    always_ff @(posedge clk) begin
        state <= next_state;
    end
    
endmodule
