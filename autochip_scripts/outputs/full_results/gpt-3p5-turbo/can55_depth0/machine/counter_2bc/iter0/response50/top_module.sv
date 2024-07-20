module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    reg [1:0] current_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01;
        end else if (train_valid) begin
            case (current_state)
                2'b00: begin
                    if (train_taken) begin
                        current_state <= 2'b01;
                    end else begin
                        current_state <= 2'b00;
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
                    if (train_taken) begin
                        current_state <= 2'b11;
                    end else begin
                        current_state <= 2'b10;
                    end
                end
                default: current_state <= 2'b01;
            endcase
        end
    end
    
    assign state = current_state;
    
endmodule
