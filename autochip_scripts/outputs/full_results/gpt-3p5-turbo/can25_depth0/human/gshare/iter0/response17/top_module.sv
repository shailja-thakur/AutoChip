module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    reg [6:0] global_history; // Global Branch History Register
    reg [6:0] index; // Index for Pattern History Table
    reg [1:0] pht [0:127]; // Pattern History Table
    reg predict_taken_reg; // Register to store predicted taken branch

    // Predict stage
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken_reg <= 0;
            predict_history <= 0;
        end else if (predict_valid) begin
            index <= predict_pc ^ global_history; // Compute the index using xor
            predict_taken_reg <= (pht[index] == 2'b11 || pht[index] == 2'b10);
            predict_history <= global_history;
        end
    end

    // Train stage
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            for (integer i = 0; i < 128; i = i + 1) begin
                pht[i] <= 0;
            end
        end else if (train_valid) begin
            index <= train_pc ^ train_history; // Compute the index using xor

            // Update PHT based on training outcome
            if (train_mispredicted) begin
                pht[index] <= (pht[index] == 2'b00) ? 2'b00 : 2'b01; // Decrement the saturating counter
            end else begin
                pht[index] <= (pht[index] == 2'b11) ? 2'b11 : 2'b10; // Increment the saturating counter
            end

            // Update global history
            global_history <= {global_history[5:0], train_taken};
        end
    end

    // Output predictions
    assign predict_taken = predict_taken_reg;

endmodule
