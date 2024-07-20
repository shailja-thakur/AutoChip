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

    // 7-bit global branch history register
    reg [6:0] GHR;

    // Index calculation using XOR
    wire [6:0] predict_index = predict_pc ^ GHR;
    wire [6:0] train_index = train_pc ^ train_history;

    // Local variables to hold counter values
    reg [1:0] prediction_counter;
    reg [1:0] training_counter;

    // Function to update saturating counters based on branch outcome
    function [1:0] update_counter(
        input [1:0] counter,
        input taken
    );
    begin
        if (taken) begin
            if (counter < 2'b11)
                update_counter = counter + 1;
            else
                update_counter = counter;
        end else begin
            if (counter > 2'b00)
                update_counter = counter - 1;
            else
                update_counter = counter;
        end
    end
    endfunction

    // Asynchronous reset
    always @(posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            // Initialize PHT counters
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;  // Weakly not taken
            end
        end
    end

    // Prediction logic
    always @(posedge clk) begin
        if (predict_valid) begin
            prediction_counter <= PHT[predict_index];
            predict_taken <= prediction_counter[1];
            predict_history <= GHR;
        end

        // Update GHR for prediction
        if (predict_valid && !train_valid) begin
            GHR <= {GHR[5:0], predict_taken};
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            training_counter <= PHT[train_index];
            PHT[train_index] <= update_counter(training_counter, train_taken);

            // If mispredicted, recover GHR to state after mispredicted branch
            if (train_mispredicted) begin
                GHR <= {train_history[5:0], train_taken};
            end else begin
                // Update GHR for correct prediction
                GHR <= {GHR[5:0], train_taken};
            end
        end
    end

endmodule
