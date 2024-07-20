module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting // Define start_shifting as a registered output
);

    // Define states using an enum
    typedef enum logic [1:0] {
        S0, // Initial state
        S1,
        S2,
        S3,
        S4
    } state_type;
    
    // Define signals
    reg [1:0] current_state = S0;
    reg [3:0] shift_reg;
    
    // Sequential block
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            current_state <= S0; // Reset the current state to S0 when reset is active high
            start_shifting <= 0; // Reset the output signal when reset is active high
        end
        else begin
            case(current_state)
                S0: begin
                    if (data) begin
                        shift_reg <= {shift_reg[2:0], data}; // Shift in the new data
                        if (shift_reg == 4'b1101) begin
                            current_state <= S1; // Transition to S1 if the sequence is found
                            start_shifting <= 1; // Set start_shifting to 1
                        end
                    end
                end
                S1: begin
                    if (data) begin
                        shift_reg <= {shift_reg[2:0], data}; // Shift in the new data
                        if (shift_reg == 4'b1101) begin
                            current_state <= S2; // Transition to S2 if the sequence is found again
                        end
                        else begin
                            current_state <= S0; // Transition back to S0 if the sequence is not found
                            start_shifting <= 0; // Set start_shifting to 0
                        end
                    end
                end
                S2: begin
                    if (data) begin
                        shift_reg <= {shift_reg[2:0], data}; // Shift in the new data
                        if (shift_reg == 4'b1101) begin
                            current_state <= S3; // Transition to S3 if the sequence is found again
                        end
                        else begin
                            current_state <= S0; // Transition back to S0 if the sequence is not found
                            start_shifting <= 0; // Set start_shifting to 0
                        end
                    end
                end
                S3: begin
                    if (data) begin
                        shift_reg <= {shift_reg[2:0], data}; // Shift in the new data
                        if (shift_reg == 4'b1101) begin
                            current_state <= S4; // Transition to S4 if the sequence is found again
                        end
                        else begin
                            current_state <= S0; // Transition back to S0 if the sequence is not found
                            start_shifting <= 0; // Set start_shifting to 0
                        end
                    end
                end
                S4: begin
                    current_state <= S4; // Stay in S4 if the sequence is found again
                    start_shifting <= 1; // Set start_shifting to 1
                end
        endcase
    end
endmodule
