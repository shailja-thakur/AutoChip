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

    // Define two-bit saturating counters
    reg [1:0] PHT [127:0]; // Pattern History Table with 128 entries
    reg [6:0] global_history; // 7-bit Global History Register
    
    wire [6:0] predict_index = predict_pc ^ global_history; // Hash to 7-bit index
    wire [6:0] train_index = train_pc ^ train_history; // Hash to 7-bit index
    
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            // Initialize PHT entries to 2'b01 (weakly not taken)
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                // Training logic
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) 
                        PHT[train_index] <= PHT[train_index] + 1;
                end else begin
                    if (PHT[train_index] != 2'b00) 
                        PHT[train_index] <= PHT[train_index] - 1;
                end
                
                if (train_mispredicted) begin
                    global_history <= (train_history << 1) | train_taken;
                end else begin
                    global_history <= (global_history << 1) | train_taken;
                end
            end else if (predict_valid) begin
                // Update global history register with the prediction
                global_history <= (global_history << 1) | predict_taken;
            end
        end
    end

    always @(*) begin
        if (areset) begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end else if (predict_valid) begin
            predict_taken = PHT[predict_index][1]; // MSB of the 2-bit counter
            predict_history = global_history;
        end
    end
endmodule
