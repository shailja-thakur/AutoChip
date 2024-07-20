module top_module(
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

    reg [6:0] global_history;
    reg [1:0] PHT [127:0];  // 128-entry table of 2-bit counters

    // Initialize the PHT and global history
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;  // weakly not taken state
            end
        end
    end

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    always @(posedge clk) begin
        if (predict_valid) begin
            predict_history <= global_history;
            predict_taken <= PHT[predict_index][1];  // use the MSB of the counter for prediction
        end

        if (train_valid) begin
            if (train_taken) begin
                if (PHT[train_index] < 2'b11)
                    PHT[train_index] <= PHT[train_index] + 1;
            end 
            else begin
                if (PHT[train_index] > 2'b00)
                    PHT[train_index] <= PHT[train_index] - 1;
            end

            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end 
            else begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
        else if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
    end
    
endmodule
