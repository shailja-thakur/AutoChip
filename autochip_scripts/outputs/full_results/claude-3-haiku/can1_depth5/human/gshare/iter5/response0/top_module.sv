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

    // 7-bit global history register
    reg [6:0] global_history;

    // 128-entry pattern history table (PHT)
    reg [1:0] pht [127:0];

    // Hash function to get index into PHT
    function [6:0] hash_pc_history(input [6:0] pc, input [6:0] history);
        hash_pc_history = pc ^ history;
    endfunction

    integer i;

    initial begin
        global_history = 7'b0;
        for (i = 0; i < 128; i = i + 1) begin
            pht[i] = 2'b01;
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            // Hash PC and history to get PHT index
            integer index = hash_pc_history(predict_pc, global_history);
            // Make prediction based on PHT counter value
            predict_taken = (pht[index] >= 2'b10);
            // Output the current global history
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history = 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] = 2'b01;
            end
        end else begin
            if (train_valid) begin
                // Hash PC and history to get PHT index
                integer index = hash_pc_history(train_pc, train_history);
                // Update PHT entry based on actual branch outcome
                if (train_taken) begin
                    pht[index] = (pht[index] == 2'b11) ? 2'b11 : pht[index] + 1'b1;
                end else begin
                    pht[index] = (pht[index] == 2'b00) ? 2'b00 : pht[index] - 1'b1;
                end
                // If the branch was mispredicted, recover the global history
                if (train_mispredicted) begin
                    global_history = train_history;
                end else begin
                    // Otherwise, update the global history
                    global_history = {global_history[5:0], train_taken};
                end
            end
        end
    end

endmodule
