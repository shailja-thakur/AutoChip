module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    // Define the current state variable
    reg [1:0] current_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the state machine to state S1
            current_state <= S1;
        end else begin
            // Transition between states based on inputs
            case (current_state)
                S0: begin
                    if (train_valid && train_taken) begin
                        current_state <= S1;
                    end else if (train_valid && !train_taken) begin
                        current_state <= S0;
                    end
                end
                S1: begin
                    if (train_valid && train_taken) begin
                        current_state <= S2;
                    end else if (train_valid && !train_taken) begin
                        current_state <= S0;
                    end
                end
                S2: begin
                    if (train_valid && train_taken) begin
                        current_state <= S3;
                    end else if (train_valid && !train_taken) begin
                        current_state <= S1;
                    end
                end
                S3: begin
                    if (train_valid && train_taken) begin
                        current_state <= S3;
                    end else if (train_valid && !train_taken) begin
                        current_state <= S2;
                    end
                end
                default: begin
                    current_state <= S1;
                end
            endcase
        end
    end

    // Assign the current state to the output
    assign state = current_state;

endmodule
