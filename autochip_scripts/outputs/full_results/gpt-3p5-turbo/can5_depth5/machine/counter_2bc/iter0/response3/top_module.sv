module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // state register
    logic [1:0] current_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01; // reset to state 1
        end else begin
            case (current_state)
                2'b00: begin
                    if (train_taken) begin
                        current_state <= 2'b01;
                    end
                end
                2'b01: begin
                    if (train_valid && train_taken) begin
                        current_state <= 2'b10;
                    end else if (train_valid && !train_taken) begin
                        current_state <= 2'b00;
                    end
                end
                2'b10: begin
                    if (train_valid && train_taken) begin
                        current_state <= 2'b11;
                    end else if (train_valid && !train_taken) begin
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
    
    assign state = current_state;
    
endmodule
