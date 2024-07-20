module top_module (
    input            clk,
    input            areset,

    input            predict_valid,
    input  [6:0]     predict_pc,
    output           predict_taken,
    output [6:0]     predict_history,

    input            train_valid,
    input            train_taken,
    input            train_mispredicted,
    input  [6:0]     train_history,
    input  [6:0]     train_pc
);

    // Global History Register
    reg [6:0] GHR;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
        end else if (train_valid && train_mispredicted) begin
            GHR <= train_history;  // Recover GHR to the state after the mispredicted branch
        end else if (predict_valid) begin
            GHR <= {GHR[5:0], predict_taken};  // Shift in the prediction taken
        end
    end

    // Pattern History Table: 128 entries of 2-bit saturating counters
    reg [1:0] PHT [0:127];

    // Index computation (pc xor GHR)
    wire [6:0] index = predict_pc ^ GHR;

    // Prediction output logic
    assign predict_history = GHR;
    assign predict_taken = (PHT[index] >= 2'b10);  // Taken if counter is in strong or weak taken state

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;  // Initialize all counters to weakly not taken
            end
        end else if (train_valid) begin
            // Compute index for training
            wire [6:0] train_index = train_pc ^ train_history;
            // Update saturating counter
            if (train_taken) begin
                // Branch taken: Increment counter
                if (PHT[train_index] < 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end
            end else begin
                // Branch not taken: Decrement counter
                if (PHT[train_index] > 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end
            end
            // Update GHR if mispredicted
            if (train_mispredicted) begin
                GHR <= train_history;
            end
        end
    end
endmodule
