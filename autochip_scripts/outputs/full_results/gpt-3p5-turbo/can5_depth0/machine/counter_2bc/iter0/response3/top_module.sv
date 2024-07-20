module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Define internal registers
    logic [1:0] current_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset state machine to state 1
            current_state <= 2'b01;
        end else if (train_valid) begin
            // Transition between states based on taken signal
            case (current_state)
                2'b00: begin
                    if (train_taken) begin
                        current_state <= 2'b01;
                    end
                end
                2'b01: begin
                    if (train_taken) begin
                        current_state <= 2'b10;
                    end else begin
                        current_state <= 2'b00;
                    end
                end
                2'b10: begin
                    if (train_taken) begin
                        current_state <= 2'b11;
                    end else begin
                        current_state <= 2'b01;
                    end
                end
                2'b11: begin
                    if (!train_taken) begin
                        current_state <= 2'b10;
                    end
                end
            endcase
        end
    end
    
    // Assign output
    assign state = current_state;
    
endmodule
