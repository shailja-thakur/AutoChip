module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);


always_ff @(posedge clk or negedge areset) begin
    if (areset) begin
        state <= 2'd1;
    end else if (train_valid) begin
        case(state)
            2'd0: if (train_taken) state <= 2'd1;
            2'd1: 
                if (train_taken) state <= 2'd2;
                else state <= 2'd0;
            2'd2: 
                if (!train_taken) state <= 2'd1;
                else state <= 2'd3;
            2'd3: 
                if (!train_taken) state <= 2'd2;
        endcase
    end
end

endmodule
