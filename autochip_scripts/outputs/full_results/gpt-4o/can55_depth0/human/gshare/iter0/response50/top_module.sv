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
    reg [1:0] pht [0:127];  // Pattern History Table with 128 2-bit entries
    reg [6:0] global_history;  // 7-bit Global History Register

    integer i;

    // Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                pht[i] <= 2'b01;  // Initialize to weakly taken
        end else begin
            if (predict_valid) begin
                // Produce the predicted branch direction
                predict_history <= global_history;
                predict_taken <= pht[predict_pc ^ global_history][1];  // MSB indicates prediction
                
                // Update history register on next posedge clock if not training
                if (!train_valid || train_mispredicted)  // Training takes precedence
                    global_history <= {global_history[5:0], predict_taken};
            end
    
            if (train_valid) begin
                // Update the PHT entry for the given pc and history
                if (train_taken) begin
                    if (pht[train_pc ^ train_history] != 2'b11)
                        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1;
                end else begin
                    if (pht[train_pc ^ train_history] != 2'b00)
                        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1;
                end

                // Recover the history register if mispredicted
                if (train_mispredicted)
                    global_history <= {train_history[5:0], train_taken};
            end
        end
    end
endmodule
