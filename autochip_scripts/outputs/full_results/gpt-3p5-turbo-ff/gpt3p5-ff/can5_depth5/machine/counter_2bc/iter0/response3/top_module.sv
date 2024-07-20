module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Define states
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    
    // Internal state variable
    logic [1:0] curr_state;
    
    // State register
    always_ff @(posedge clk, posedge areset)
    begin
        if (areset)
            curr_state <= S1;
        else if (train_valid)
        begin
            case (curr_state)
                S0:
                    if (train_taken)
                        curr_state <= S1;
                    else
                        curr_state <= S0;
                S1:
                    if (train_taken && curr_state < S3)
                        curr_state <= curr_state + 1;
                    else if (!train_taken && curr_state > S0)
                        curr_state <= curr_state - 1;
                    else
                        curr_state <= curr_state;
                S2:
                    if (train_taken && curr_state < S3)
                        curr_state <= curr_state + 1;
                    else if (!train_taken && curr_state > S0)
                        curr_state <= curr_state - 1;
                    else
                        curr_state <= curr_state;
                S3:
                    if (train_taken)
                        curr_state <= S1;
                    else
                        curr_state <= S3;
            endcase
        end
    end
    
    // Output mapping
    always_comb
    begin
        state <= curr_state;
    end
endmodule
