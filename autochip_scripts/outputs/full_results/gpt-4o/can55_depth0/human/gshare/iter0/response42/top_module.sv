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

    // 128-entry table of two-bit saturating counters
    reg [1:0] PHT [0:127];  
    reg [6:0] global_history;

    wire [6:0] predict_index;
    wire [6:0] train_index;

    // Index calculation by XORing PC and global history
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Interpretation of 2-bit saturating counter
    wire [1:0] predict_counter = PHT[predict_index];
    wire [1:0] train_counter = PHT[train_index];

    always @* begin
        predict_taken = predict_counter[1];
        predict_history = global_history;
    end

    integer i;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01;  // Weakly not taken initial state
        end else begin
            if (train_valid) begin
                // Update saturating counter
                if (train_taken) begin
                    if (train_counter != 2'b11) begin
                        PHT[train_index] <= train_counter + 1;
                    end
                end else begin
                    if (train_counter != 2'b00) begin
                        PHT[train_index] <= train_counter - 1;
                    end
                end

                // Update global_history if misprediction
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end
            end

            if (predict_valid && !train_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
