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

    // Define constants
    localparam PHT_SIZE = 128;
    localparam COUNTER_BITS = 2;
    localparam HISTORY_BITS = 7;
    
    // Define branch history register
    reg [HISTORY_BITS-1:0] global_history;

    // Define pattern history table (PHT)
    reg [COUNTER_BITS-1:0] pattern_history_table[PHT_SIZE-1:0];

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else begin
            if (predict_valid && !train_valid) begin
                // Update global history register for prediction
                global_history <= {global_history[HISTORY_BITS-2:0], predict_taken};
            end else if (train_valid && train_mispredicted) begin
                // Recover global history register for mispredictions
                global_history <= train_history;
            end else if (train_valid) begin
                // Update global history register for training
                global_history <= {global_history[HISTORY_BITS-2:0], train_taken};
            end
        end
    end

    // Prediction logic
    always @* begin
        if (predict_valid) begin
            // Compute index for the PHT
            predict_history = global_history;
            integer index = predict_pc ^ global_history;
            index = index % PHT_SIZE; // Ensuring index is within bounds

            // Read counter value from the PHT
            case (pattern_history_table[index])
                2'b00, 2'b01: predict_taken = 0; // Strongly not taken, weakly not taken
                2'b10, 2'b11: predict_taken = 1; // Weakly taken, strongly taken
                default: predict_taken = 0;
            endcase
        end else begin
            predict_taken = 0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            // Compute index for the PHT
            integer index = train_pc ^ train_history;
            index = index % PHT_SIZE; // Ensuring index is within bounds

            // Update counter value in the PHT
            if (train_taken) begin
                if (pattern_history_table[index] < 2'b11) begin
                    pattern_history_table[index] = pattern_history_table[index] + 1;
                end
            end else begin
                if (pattern_history_table[index] > 2'b00) begin
                    pattern_history_table[index] = pattern_history_table[index] - 1;
                end
            end
        end
    end

endmodule
