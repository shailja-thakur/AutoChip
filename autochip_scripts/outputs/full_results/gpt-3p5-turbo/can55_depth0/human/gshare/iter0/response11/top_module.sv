module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

reg [1:0] pht [127:0];
reg [6:0] bhr;
reg [6:0] predict_index;

always @(posedge clk or posedge areset) begin
    if (areset)
    begin
        // Reset to initial values
        pht <= 2'b00;
        bhr <= 7'b0;
        predict_index <= 7'b0;
    end
    else
    begin
        // Compute index for prediction
        predict_index <= predict_pc ^ bhr;
        // Make prediction based on the saturating counter value
        predict_taken <= (pht[predict_index] >= 2'b10);
    end
end

always @(posedge clk or posedge areset) begin
    if (areset)
    begin
        // Reset to initial values
        pht <= 2'b00;
        bhr <= 7'b0;
    end
    else if (train_valid)
    begin
        // Update branch history register
        bhr <= {bhr[5:0], train_taken};
        // Update PHT based on the outcome of the branch
        if (train_mispredicted)
            pht[train_pc ^ bhr] <= pht[train_pc ^ bhr] <= 2'b00;
        else
            pht[train_pc ^ bhr] <= pht[train_pc ^ bhr] + 1;
    end
end

always @(posedge clk) begin
    // Output branch history register
    predict_history <= bhr;
end

endmodule
