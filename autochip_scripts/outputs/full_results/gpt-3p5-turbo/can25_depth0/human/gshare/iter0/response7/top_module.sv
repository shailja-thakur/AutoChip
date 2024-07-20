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

    reg [1:0] pht_table [127:0];
    reg [6:0] history_reg;

    // Prediction
    reg [1:0] predict_counter;
    reg predict_taken_reg;
    reg [6:0] predict_history_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_counter <= 0;
            predict_taken_reg <= 0;
            predict_history_reg <= 0;
        end else if (predict_valid) begin
            predict_taken_reg <= pht_table[predict_pc ^ predict_history_reg][predict_counter];
            predict_counter <= predict_counter + 2'b01;
            predict_history_reg <= predict_history_reg << 1 | predict_taken_reg;
        end
    end

    assign predict_taken = predict_taken_reg;
    assign predict_history = predict_history_reg;

    // Training
    reg [1:0] train_counter;
    reg [6:0] train_history_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            train_counter <= 0;
            train_history_reg <= 0;
        end else if (train_valid) begin
            train_history_reg <= train_history;
            if (train_mispredicted) begin
                pht_table[train_pc ^ train_history][train_counter] <= $signed(pht_table[train_pc ^ train_history][train_counter]) - 1;
            end else begin
                pht_table[train_pc ^ train_history][train_counter] <= $signed(pht_table[train_pc ^ train_history][train_counter]) + 1;
            end
            train_counter <= train_counter + 2'b01;
        end
    end

endmodule
