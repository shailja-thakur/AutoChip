module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    logic [1:0] next_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1;
        else if (train_valid && train_taken && (state < 3))
            state <= state + 1;
        else if (train_valid && !train_taken && (state > 0))
            state <= state - 1;
    end
    
endmodule
