module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
 
    // Internal signal declarations
    logic [1:0] next_state;
 
    // Initial state assignment
    always_ff @(posedge clk, posedge areset)
    begin
        if(areset)
            state <= 2'b01;
        else
            state <= next_state;
    end
 
    // Next state logic
    always_comb
    begin
        case({train_valid, train_taken})
            2'b11: next_state = (state == 2'b11) ? 2'b11 : state + 1;
            2'b10: next_state = state;
            2'b01: next_state = (state == 2'b00) ? 2'b00 : state - 1;
            2'b00: next_state = state;
            default: next_state = state;
        endcase
    end
endmodule
