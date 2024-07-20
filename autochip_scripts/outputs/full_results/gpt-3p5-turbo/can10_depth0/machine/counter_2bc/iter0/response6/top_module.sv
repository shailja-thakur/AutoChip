module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    logic [1:0] current_state;
    
    always_ff @(posedge clk)
    begin
        if (areset)
            current_state <= 2'b01;
        else if (train_valid)
        begin
            case (current_state)
                2'b00: if (train_taken) current_state <= 2'b01; else current_state <= 2'b00;
                2'b01: if (train_taken) current_state <= 2'b10; else current_state <= 2'b00;
                2'b10: if (train_taken) current_state <= 2'b11; else current_state <= 2'b01;
                2'b11: if (!train_taken) current_state <= 2'b10; else current_state <= 2'b11;
            endcase
        end
    end
    
    assign state = current_state;
    
endmodule
