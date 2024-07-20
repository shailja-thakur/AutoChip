module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always @(posedge clk, posedge areset) begin
        
        if (areset)
            state <= 2'b01;
        else if (train_valid && train_taken && (state < 2))
            state <= state + 1;
        else if (train_valid && !train_taken && (state > 0))
            state <= state - 1;
            
    end

endmodule
