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

    // Global History Register
    reg [6:0] global_history;

    // Pattern History Table (PHT) - 128 entries of 2-bit saturating counters
    reg [1:0] PHT [0:127];

    // Initialize the PHT and GHR on reset
    integer i;
    always @(posedge areset) begin
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] <= 2'b01; // Weakly not taken
        end
        global_history <= 7'b0;
    end

    wire [6:0] predict_index;
    assign predict_index = predict_pc ^ global_history;

    reg [1:0] predict_pht_state;
    always @(posedge clk) begin
        if (predict_valid) begin
            predict_pht_state <= PHT[predict_index];
        end
    end

    assign predict_taken = (predict_pht_state[1] == 1'b1);
    assign predict_history = global_history;

    // Training logic
    wire [6:0] train_index;
    assign train_index = train_pc ^ train_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset logic
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly not taken
            end
            global_history <= 7'b0;
        end else if (train_valid) begin
            // Training logic, including PHT update and GHR recovery in case of mispredictions
            if (train_taken) begin
                if (PHT[train_index] != 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 2'b01; // Increase confidence
                end
            end else begin
                if (PHT[train_index] != 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 2'b01; // Decrease confidence
                end
            end
            
            // Recover GHR if mispredicted
            if (train_mispredicted) begin
                global_history <= train_history; // Recover GHR
            end else begin
                // Update GHR with the outcome of the branch
                global_history <= {global_history[5:0], train_taken};
            end
        end else if (predict_valid && !train_valid) begin
            // If predicting and not training, update the global history register
            global_history <= {global_history[5:0], predict_pht_state[1]};
        end
    end

endmodule
