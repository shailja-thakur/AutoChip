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

localparam PHT_SIZE = 128;
reg [1:0] pht[PHT_SIZE-1:0]; // Pattern History Table

reg [6:0] global_history;

always @(*) begin
    // Prediction logic
    if (predict_valid) begin
        // Hash PC and global history to get PHT index
        integer pht_index = predict_pc ^ global_history;
        // Get prediction from PHT
        predict_taken = (pht[pht_index] >= 2'b10);
        predict_history = global_history;
    end else begin
        predict_taken = 1'b0;
        predict_history = 7'b0;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (integer i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b01; // Initialize PHT to weakly not-taken
        end
    end else begin
        // Training logic
        if (train_valid) begin
            // Update global history
            if (train_taken) begin
                global_history <= (global_history << 1) | 1'b1;
            end else begin
                global_history <= (global_history << 1) & 7'b1111110;
            end

            // Update PHT
            integer pht_index = train_pc ^ train_history;
            case (pht[pht_index])
                2'b00: pht[pht_index] <= train_taken ? 2'b01 : 2'b00;
                2'b01: pht[pht_index] <= train_taken ? 2'b10 : 2'b00;
                2'b10: pht[pht_index] <= train_taken ? 2'b11 : 2'b01;
                2'b11: pht[pht_index] <= train_taken ? 2'b11 : 2'b10;
            endcase

            // Recover global history on misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end else begin
            // Update global history based on prediction
            if (predict_valid) begin
                if (predict_taken) begin
                    global_history <= (global_history << 1) | 1'b1;
                end else begin
                    global_history <= (global_history << 1) & 7'b1111110;
                end
            end
        end
    end
end

endmodule
