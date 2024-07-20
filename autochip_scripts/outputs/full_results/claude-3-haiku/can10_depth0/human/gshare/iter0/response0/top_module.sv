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

localparam PHT_SIZE = 128;
reg [1:0] pht[PHT_SIZE-1:0];
reg [6:0] global_history;

// Hash function for indexing the PHT
function [6:0] hash_pc(input [6:0] pc);
    begin
        hash_pc = pc ^ global_history;
    end
endfunction

// Update the global history register
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
    end
    else begin
        if (train_valid) begin
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
        else if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
    end
end

// Predict branch direction
always @* begin
    if (predict_valid) begin
        predict_history = global_history;
        predict_taken = pht[hash_pc(predict_pc)][1];
    end
    else begin
        predict_taken = 1'b0;
        predict_history = 7'b0;
    end
end

// Train the branch predictor
always @(posedge clk or posedge areset) begin
    if (areset) begin
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b01;
        end
    end
    else begin
        if (train_valid) begin
            if (train_mispredicted) begin
                pht[hash_pc(train_pc)] <= (train_taken) ? 2'b10 : 2'b01;
            end
            else begin
                pht[hash_pc(train_pc)] <= (train_taken) ? 2'b11 : 2'b00;
            end
        end
    end
end

endmodule
