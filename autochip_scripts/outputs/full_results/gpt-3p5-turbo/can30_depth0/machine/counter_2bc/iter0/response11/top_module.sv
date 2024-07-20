module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal declarations
    logic [1:0] current_state;
    
    // State machine values
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;
    
    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            if (train_valid) begin
                if (train_taken && (current_state < STATE_3)) begin
                    current_state <= current_state + 1;
                end else if (!train_taken && (current_state > STATE_0)) begin
                    current_state <= current_state - 1;
                end
            end
        end
    end
    
    // Output assignment
    always_comb begin
        state <= current_state;
    end

endmodule
