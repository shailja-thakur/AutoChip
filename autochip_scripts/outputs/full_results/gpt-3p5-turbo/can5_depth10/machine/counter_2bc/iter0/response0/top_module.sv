module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define states
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    // Define internal wire for next state
    wire [1:0] next_state;
    
    // Define flip-flops for current state and next state
    logic [1:0] curr_state;
    
    // Initial state
    assign curr_state = S1;

    // Next state logic
    always @(posedge clk, negedge areset) begin
        if (areset) begin
            curr_state <= S1; // Reset state
        end else begin
            case (curr_state)
                S0: begin
                    if (train_valid && train_taken) begin
                        next_state <= S1; // Transition to next state S1
                    end else begin
                        next_state <= S0; // Remain in S0
                    end
                end

                S1: begin
                    if (train_valid && train_taken && (curr_state < S3)) begin
                        next_state <= curr_state + 1; // Transition to next state
                    end else if (train_valid && !train_taken && (curr_state > S0)) begin
                        next_state <= curr_state - 1; // Transition to previous state
                    end else begin
                        next_state <= S1; // Remain in S1
                    end
                end

                S2: begin
                    if (train_valid && train_taken && (curr_state < S3)) begin
                        next_state <= curr_state + 1; // Transition to next state
                    end else if (train_valid && !train_taken && (curr_state > S0)) begin
                        next_state <= curr_state - 1; // Transition to previous state
                    end else begin
                        next_state <= S2; // Remain in S2
                    end
                end

                S3: begin
                    if (train_valid && train_taken) begin
                        next_state <= S3; // Remain in S3
                    end else if (train_valid && !train_taken && (curr_state > S0)) begin
                        next_state <= curr_state - 1; // Transition to previous state
                    end else begin
                        next_state <= S3; // Remain in S3
                    end
                end
            
            endcase
        end
    end

    // Output assignment
    assign state = curr_state;

endmodule
