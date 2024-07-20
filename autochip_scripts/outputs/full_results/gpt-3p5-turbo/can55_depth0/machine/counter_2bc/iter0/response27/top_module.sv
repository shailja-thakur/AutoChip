module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // State register
    reg [1:0] current_state;
    
    // Next state logic
    always_ff @(posedge clk, negedge areset) begin
        if (areset)
            current_state <= 1;
        else if (train_valid) begin
            case (current_state)
                2'b00: if (train_taken) current_state <= 2;
                2'b01: if (!train_taken) current_state <= 0;
                2'b10: if (train_taken) current_state <= 3;
                2'b11: if (!train_taken) current_state <= 1;
            endcase
        end
    end
    
    // Output assignment
    always_comb begin
        state = current_state;
    end
endmodule
