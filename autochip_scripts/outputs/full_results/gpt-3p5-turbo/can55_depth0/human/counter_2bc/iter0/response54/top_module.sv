module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to store the current state
    reg [1:0] current_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to weakly not-taken
            current_state <= 2'b01;
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    // Increment when train_valid and train_taken are both 1
                    if (current_state == 2'b11) begin
                        current_state <= 2'b11;
                    end else begin
                        current_state <= current_state + 1;
                    end
                end else begin
                    // Decrement when train_valid is 1 and train_taken is 0
                    if (current_state == 2'b00) begin
                        current_state <= 2'b00;
                    end else begin
                        current_state <= current_state - 1;
                    end
                end
            end
        end
    end

    // Output the current state
    assign state = current_state;

endmodule
