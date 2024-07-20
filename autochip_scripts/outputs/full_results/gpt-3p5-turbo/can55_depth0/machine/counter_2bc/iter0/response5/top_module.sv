module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // internal state variable
    logic [1:0] current_state;
    
    // default initial state
    initial begin
        current_state = 2'b01;
    end
    
    // asynchronous reset
    always @(posedge areset) begin
        current_state <= 2'b01;
    end
    
    // state transitions
    always @(posedge clk) begin
        if (train_valid) begin
            case (current_state)
                2'b00: if (train_taken) current_state <= 2'b01;
                2'b01: if (train_taken) current_state <= 2'b10;
                        else current_state <= 2'b00;
                2'b10: if (!train_taken) current_state <= 2'b01;
                2'b11: if (!train_taken) current_state <= 2'b10;
            endcase
        end
    end
    
    // output assignment
    assign state = current_state;
    
endmodule
