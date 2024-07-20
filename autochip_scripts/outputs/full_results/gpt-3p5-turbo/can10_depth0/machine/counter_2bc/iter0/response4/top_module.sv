module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    logic [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1;
        else if (train_valid) begin
            case (state)
                0: state <= (train_taken) ? 1 : 0;
                1: state <= (train_taken) ? 2 : 0;
                2: state <= (train_taken) ? 3 : 1;
                3: state <= (train_taken) ? 3 : 2;
            endcase
        end
    end
    
    assign next_state = state;
    
endmodule
