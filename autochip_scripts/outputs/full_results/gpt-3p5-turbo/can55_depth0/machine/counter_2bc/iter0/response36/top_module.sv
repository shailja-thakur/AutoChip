module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Define the states
    typedef enum logic [1:0] {STATE_0, STATE_1, STATE_2, STATE_3} state_type;
    
    // Define the state signal
    logic [1:0] current_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            case (current_state)
                STATE_0:
                    if (train_taken && (current_state < STATE_3))
                        current_state <= current_state + 1;
                    else if (!train_taken && (current_state > STATE_0))
                        current_state <= current_state - 1;
                        
                STATE_1:
                    if (train_valid)
                        current_state <= STATE_2;
                        
                STATE_2:
                    if (train_taken && (current_state < STATE_3))
                        current_state <= current_state + 1;
                    else if (!train_taken && (current_state > STATE_0))
                        current_state <= current_state - 1;
                        
                STATE_3:
                    if (!train_taken && (current_state > STATE_0))
                        current_state <= current_state - 1;
            endcase
        end
    end
    
    assign state = current_state;
    
endmodule
