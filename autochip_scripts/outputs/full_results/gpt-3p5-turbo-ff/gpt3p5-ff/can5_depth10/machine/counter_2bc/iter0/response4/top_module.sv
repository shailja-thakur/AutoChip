module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    parameter STATE_2 = 2'b10;
    parameter STATE_3 = 2'b11;
    
    // Define the current state register
    reg [1:0] current_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            // State transition logic
            case (current_state)
                STATE_0: begin
                    if (train_taken && current_state < STATE_3) begin
                        current_state <= current_state + 1;
                    end else begin
                        current_state <= current_state;
                    end
                end
                
                STATE_1: begin
                    if (train_valid) begin
                        if (train_taken) begin
                            current_state <= current_state + 1;
                        end else begin
                            current_state <= STATE_0;
                        end
                    end else begin
                        current_state <= current_state;
                    end
                end
                
                STATE_2: begin
                    if (!train_taken && current_state > STATE_0) begin
                        current_state <= current_state - 1;
                    end else begin
                        current_state <= current_state;
                    end
                end
                
                STATE_3: begin
                    if (!train_taken) begin
                        current_state <= current_state - 1;
                    end else begin
                        current_state <= current_state;
                    end
                end
            endcase
        end
    end

    // Assign the state output
    assign state = current_state;

endmodule
