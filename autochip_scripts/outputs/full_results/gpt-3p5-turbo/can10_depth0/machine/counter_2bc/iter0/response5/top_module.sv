module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    //state register
    logic [1:0] next_state;
    always @(posedge clk, negedge areset) begin
        if (areset) begin 
            state <= 1;
            next_state <= 1;
        end 
        else begin
            state <= next_state;
            if (train_valid) begin
                if (train_taken && (state < 3))
                    next_state <= state + 1;
                else if (!train_taken && (state > 0))
                    next_state <= state - 1;
                else
                    next_state <= state;
            end
        end
    end
   
endmodule
