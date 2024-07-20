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

reg [6:0] global_history;
reg [1:0] pht [127:0];

// Prediction logic
wire [6:0] predict_index = predict_pc ^ global_history;
assign predict_taken = pht[predict_index][1];
assign predict_history = global_history;

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
    end
    else begin
        if (train_valid) begin
            // Update global history register
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                global_history <= (global_history << 1) | train_taken;
            end

            // Update pattern history table
            wire [6:0] train_index = train_pc ^ train_history;
            if (train_taken) begin
                pht[train_index] <= (pht[train_index] == 2'b11) ? 2'b11 : pht[train_index] + 1'b1;
            end
            else begin
                pht[train_index] <= (pht[train_index] == 2'b00) ? 2'b00 : pht[train_index] - 1'b1;
            end
        end
        else if (predict_valid) begin
            // Update global history register for the predicted branch
            global_history <= (global_history << 1) | predict_taken;
        end
    end
end

endmodule
