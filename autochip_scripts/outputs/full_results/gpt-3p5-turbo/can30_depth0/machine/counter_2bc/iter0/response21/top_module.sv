module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
 
reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 1;
    else if (train_valid) begin
        if (train_taken && (state < 3))
            state <= state + 1;
        else if (!train_taken && (state > 0))
            state <= state - 1;
    end
end

assign state = state;

endmodule
