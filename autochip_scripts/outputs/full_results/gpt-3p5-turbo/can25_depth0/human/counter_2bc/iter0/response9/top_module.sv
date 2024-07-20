module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define internal signals
    logic [1:0] next_state;
    
    // Saturating counter logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            next_state <= 2'b01;
        end else if (train_valid) begin
            if (train_taken && (next_state != 2'b11)) begin
                next_state <= next_state + 1;
            end else if (!train_taken && (next_state != 2'b00)) begin
                next_state <= next_state - 1;
            end
        end
    end

    // Assign output
    assign state = next_state;

endmodule
