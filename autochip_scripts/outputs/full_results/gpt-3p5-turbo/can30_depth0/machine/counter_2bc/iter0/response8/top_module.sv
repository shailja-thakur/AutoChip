module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    reg [1:0] current_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01;
        else if (train_valid) begin
            case (current_state)
                2'b00: current_state <= 2'b01;
                2'b01: begin
                    if (train_taken)
                        current_state <= 2'b10;
                    else
                        current_state <= 2'b00;
                end
                2'b10: begin
                    if (train_taken)
                        current_state <= 2'b11;
                    else
                        current_state <= 2'b01;
                end
                2'b11: begin
                    if (train_taken)
                        current_state <= 2'b11;
                    else
                        current_state <= 2'b10;
                end
            endcase
        end
    end
    
    assign state = current_state;
endmodule
