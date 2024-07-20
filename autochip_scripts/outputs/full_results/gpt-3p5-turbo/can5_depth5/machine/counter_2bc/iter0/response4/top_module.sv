module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    logic [1:0] current_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01;
        end else begin
            case (current_state)
                2'b00: begin
                    if (train_taken & (current_state < 2'b11)) begin
                        current_state <= current_state + 1;
                    end else if (!train_taken & (current_state > 2'b00)) begin
                        current_state <= current_state - 1;
                    end
                end
                2'b01: begin
                    if (train_valid) begin
                        current_state <= train_taken ? 2'b10 : 2'b00;
                    end
                end
                2'b10: begin
                    if (train_taken & (current_state < 2'b11)) begin
                        current_state <= current_state + 1;
                    end else if (!train_taken & (current_state > 2'b00)) begin
                        current_state <= current_state - 1;
                    end
                end
                2'b11: begin
                    if (train_valid) begin
                        current_state <= train_taken ? 2'b10 : 2'b01;
                    end
                end
                default: current_state <= 2'b00;
            endcase
        end
    end
    
    assign state = current_state;
    
endmodule
