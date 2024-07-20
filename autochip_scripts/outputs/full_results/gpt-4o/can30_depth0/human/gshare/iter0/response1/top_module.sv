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
    // 128-entry Pattern History Table (PHT) with 2-bit saturating counters
    reg [1:0] counter_table [0:127];
    reg [6:0] global_history;

    // Function to increment the 2-bit saturating counter
    function [1:0] counter_inc;
        input [1:0] ctr;
        begin
            if (ctr < 2'b11) 
                counter_inc = ctr + 1;
            else 
                counter_inc = ctr;
        end
    endfunction

    // Function to decrement the 2-bit saturating counter
    function [1:0] counter_dec;
        input [1:0] ctr;
        begin
            if (ctr > 2'b00) 
                counter_dec = ctr - 1;
            else 
                counter_dec = ctr;
        end
    endfunction

    // Reset and global history initialization
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (integer i = 0; i < 128; i = i + 1)
                counter_table[i] <= 2'b01;  // Initialize to weakly taken (01)
        end else if (train_valid) begin
            if (train_taken) begin
                counter_table[train_pc ^ train_history] <= counter_inc(counter_table[train_pc ^ train_history]);
            end else begin
                counter_table[train_pc ^ train_history] <= counter_dec(counter_table[train_pc ^ train_history]);
            end

            if (train_mispredicted) begin
                global_history <= {global_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], (train_valid ? train_taken : predict_taken)};
            end
        end else if (predict_valid) begin
            global_history <= {global_history[5:0], counter_table[predict_pc ^ global_history][1]};
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            predict_taken = counter_table[predict_pc ^ global_history][1];
        end else begin
            predict_history = 7'b0;
            predict_taken = 1'b0;
        end
    end
endmodule
