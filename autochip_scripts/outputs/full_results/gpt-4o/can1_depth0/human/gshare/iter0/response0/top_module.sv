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

    // Define the 2-bit saturating counter table (PHT)
    reg [1:0] pattern_history_table [127:0];

    // Define the global branch history register
    reg [6:0] global_history;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end
        else begin
            if (train_valid && train_mispredicted) begin
                global_history <= train_history;
            end
            else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end
    
    // Prediction logic
    wire [6:0] gshare_index;
    assign gshare_index = predict_pc ^ global_history;

    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            predict_taken = (pattern_history_table[gshare_index] >= 2'b10) ? 1 : 0;
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            if (train_taken && pattern_history_table[gshare_index] != 2'b11)
                pattern_history_table[gshare_index] <= pattern_history_table[gshare_index] + 1;
            else if (!train_taken && pattern_history_table[gshare_index] != 2'b00)
                pattern_history_table[gshare_index] <= pattern_history_table[gshare_index] - 1;
        end
    end

endmodule
