module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Internal register to hold the current state
    reg [1:0] current_state;

    // Assign initial state based on reset signal
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01;
        end else begin
            current_state <= current_state;
        end
    end

    // State machine logic
    always @(posedge clk) begin
        if (train_valid) begin
            if (train_taken && (current_state < 2'b11)) begin
                current_state <= current_state + 1'b1;
            end else if (!train_taken && (current_state > 2'b00)) begin
                current_state <= current_state - 1'b1;
            end 
        end else begin
            current_state <= current_state; // No state change when train_valid is low
        end
    end

    // Assign current state to output
    always @(current_state) begin
        state <= current_state;
    end

endmodule
