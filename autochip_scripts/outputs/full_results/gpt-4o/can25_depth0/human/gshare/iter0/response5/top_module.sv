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
    
    // Define the 128-entry table of two-bit saturating counters
    reg [1:0] PHT [127:0];
    
    // 7-bit global branch history register
    reg [6:0] global_history;
    
    // Local variables
    reg [6:0] index;
    reg [1:0] counter;
    
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i; 
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b10; // Initialize to weakly taken (10)
            end
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    if (PHT[index] < 2'b11) begin
                        PHT[index] <= PHT[index] + 1;
                    end
                end else begin
                    if (PHT[index] > 2'b00) begin
                        PHT[index] <= PHT[index] - 1;
                    end
                end
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end
    
    always @(*) begin
        index = predict_pc ^ global_history;
        counter = PHT[index];
        predict_taken = (counter >= 2'b10);
        predict_history = global_history;
    end
    
endmodule
