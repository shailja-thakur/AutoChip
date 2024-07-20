module gshare_predictor (
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    parameter PHT_SIZE = 128;
    reg [1:0] pht [PHT_SIZE-1:0];
    reg [6:0] global_history;

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            // Hash PC and global history to get PHT index
            predict_history = global_history;
            predict_taken = (pht[predict_pc ^ global_history][1]) ? 1'b1 : 1'b0;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < PHT_SIZE; i++) begin
                pht[i] <= 2'b10;
            end
        end else begin
            if (train_valid) begin
                // Update PHT entry
                pht[train_pc ^ train_history] <= (train_taken) ? (pht[train_pc ^ train_history] == 2'b00) ? 2'b01 : pht[train_pc ^ train_history] + 2'b01 : 
                                                                (pht[train_pc ^ train_history] == 2'b11) ? 2'b10 : pht[train_pc ^ train_history] - 2'b01;

                // Update global history register
                global_history <= (train_mispredicted) ? train_history : {global_history[5:0], train_taken};
            end
        end
    end

endmodule
